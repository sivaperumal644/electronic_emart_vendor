import 'package:electronic_emart_vendor/components/offer_poster_inventory_item.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class AddPosterInventoryScreen extends StatefulWidget {
  final Function onSelectionCompleted;
  final List inventory;

  const AddPosterInventoryScreen({this.onSelectionCompleted, this.inventory});
  @override
  _AddPosterInventoryScreenState createState() =>
      _AddPosterInventoryScreenState();
}

class _AddPosterInventoryScreenState extends State<AddPosterInventoryScreen> {
  List<Inventory> selectedInventories = [];

  @override
  void initState() {
    super.initState();
    if (widget.inventory.length != 0) {
      for (int i = 0; i < widget.inventory.length; i++) {
        setState(() {
          selectedInventories.add(widget.inventory[i]);
        });
      }
    } else {
      setState(() {
        selectedInventories = [];
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
          searchBar(),
          Container(height: 24),
          getVendorInventoryQueryComponent(),
        ],
      ),
    );
  }

  Widget offerPosterInventoryItem(List<Inventory> inventories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: inventories.length,
      itemBuilder: (context, index) {
        if (inventories.length == 0) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Text(
                'No items in inventory',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: GREY_COLOR,
                ),
              ),
            ),
          );
        }
        return OfferPosterInventoryItem(
          isAddOfferInventory: true,
          inventoryItem: inventories[index],
          selectedInventories: selectedInventories,
          onTap: (val) {
            final isSelected =
                selectedInventories.where((inventory) => inventory.id == val);
            if (isSelected.length == 0)
              setState(() {
                selectedInventories.add(inventories[index]);
              });
            else
              setState(() {
                selectedInventories.remove(inventories[index]);
              });
          },
        );
      },
    );
  }

  Widget searchBar() {
    final appState = Provider.of<AppState>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width / 1.28,
      child: CustomTextField(
        hintText: 'Search for items',
        obscureText: false,
        onChanged: (text) {
          appState.setPosterSearchText(text);
        },
      ),
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
                'Add Items',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          TertiaryButton(
            text: 'DONE',
            onPressed: () {
              widget.onSelectionCompleted(selectedInventories);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget getVendorInventoryQueryComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInventoryQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorInventory'] != null &&
            result.data['getVendorInventory']['inventory'] != null) {
          List inventoryList = result.data['getVendorInventory']['inventory'];
          final inventories =
              inventoryList.map((item) => Inventory.fromJson(item)).toList();
          inventories.sort((a, b) => a.name.compareTo(b.name));

          return offerPosterInventoryItem(inventories);
        }
        return Container();
      },
    );
  }
}
