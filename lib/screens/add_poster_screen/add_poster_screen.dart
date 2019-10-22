import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/imageSelectionWidget.dart';
import 'package:electronic_emart_vendor/components/offer_poster_inventory_item.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/modals/PosterModel.dart';
import 'package:electronic_emart_vendor/screens/add_poster_inventory_screen/add_poster_inventory_screen.dart';
import 'package:electronic_emart_vendor/screens/add_poster_screen/poster_input_graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AddPosterScreen extends StatefulWidget {
  final bool isNewPoster;
  final PosterModel poster;

  const AddPosterScreen({
    this.isNewPoster = true,
    this.poster,
  });
  @override
  _AddPosterScreenState createState() => _AddPosterScreenState();
}

class _AddPosterScreenState extends State<AddPosterScreen> {
  String posterImage = "";
  List<Inventory> selectedInventories = [];
  List<String> inventoryIdsList = [];
  bool isButtonClicked = false;
  bool isDeleteButtonClicked = false;

  @override
  void initState() {
    super.initState();
    if (widget.isNewPoster == false) {
      setState(() {
        posterImage = widget.poster.posterImage;
        for (int i = 0; i < widget.poster.inventory.length; i++) {
          selectedInventories.add(widget.poster.inventory[i]);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          appBar(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Upload Poster Image',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 24),
          ImageSelectionWidget(
            existingUrl: posterImage == "" ? null : posterImage,
            onUserImageSet: (val) {
              setState(() {
                posterImage = val;
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            height: 1,
            color: PRIMARY_COLOR.withOpacity(0.3),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Items in offer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                PrimaryButtonWidget(
                  buttonText: 'ADD',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPosterInventoryScreen(
                          onSelectionCompleted: (List<Inventory> inventories) {
                            setState(() {
                              selectedInventories = inventories;
                            });
                          },
                          inventory: selectedInventories.length == 0
                              ? []
                              : selectedInventories,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Container(height: 24),
          if (selectedInventories.length == 0)
            Center(
              child: Text(
                'No items in inventory',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: GREY_COLOR,
                ),
              ),
            ),
          offerItemsList(selectedInventories),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            height: 1,
            color: PRIMARY_COLOR.withOpacity(0.3),
          ),
          widget.isNewPoster
              ? Container()
              : isDeleteButtonClicked
                  ? CupertinoActivityIndicator()
                  : deletePosterMutationComponent(),
          Container(height: 20),
        ],
      ),
    );
  }

  Widget removeButton(RunMutation runMutation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TertiaryButton(
          text: 'Remove this poster',
          isRed: true,
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return DialogStyle(
                    titleMessage: 'Delete Poster?',
                    contentMessage:
                        'Are you sure you want to delete this poster.',
                    isDelete: true,
                    isRegister: true,
                    deleteOnPressed: () {
                      setState(() {
                        isDeleteButtonClicked = true;
                      });
                      Navigator.pop(context);
                      runMutation({
                        'posterId': widget.poster.id,
                      });
                    },
                  );
                });
          },
        ),
      ],
    );
  }

  Widget offerItemsList(List<Inventory> inventories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: inventories.length,
      itemBuilder: (context, index) {
        return OfferPosterInventoryItem(
          inventoryItem: inventories[index],
          selectedInventories: [],
          onTap: (val) {
            setState(() {
              selectedInventories.remove(inventories[index]);
            });
          },
        );
      },
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 24, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: PRIMARY_COLOR,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(width: 20),
              Text(
                widget.isNewPoster ? 'Add Poster' : 'Edit Poster',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          isButtonClicked
              ? CupertinoActivityIndicator()
              : addPosterMutationComponent(),
        ],
      ),
    );
  }

  Widget doneButton(RunMutation runMutation) {
    return TertiaryButton(
      text: 'DONE',
      onPressed: () {
        setState(() {
          isButtonClicked = true;
        });
        if (posterImage == "" || inventoryIdsList == []) {
          setState(() {
            isButtonClicked = false;
          });
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogStyle(
                  titleMessage: 'Enter all Fields',
                  contentMessage:
                      'Add an image to the poster and the inventories for the poster. And then try to create poster.',
                  isRegister: false,
                );
              });
        } else {
          for (int i = 0; i < selectedInventories.length; i++) {
            setState(() {
              inventoryIdsList.add(selectedInventories[i].id);
            });
          }
          if (widget.isNewPoster == true) {
            runMutation({
              'inventoryIds': inventoryIdsList,
              'posterImage': posterImage,
            });
          } else {
            runMutation({
              'inventoryIds': inventoryIdsList,
              'posterImage': posterImage,
              'posterId': widget.poster.id,
            });
          }
        }
      },
    );
  }

  Widget addPosterMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: addPosterMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return doneButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null && resultData['addPoster']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget deletePosterMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: deletePosterMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return removeButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null && resultData['deletePoster']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
