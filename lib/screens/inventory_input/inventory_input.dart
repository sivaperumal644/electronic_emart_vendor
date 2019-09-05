import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/imageSelectionWidget.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AddInventoryScreen extends StatefulWidget {
  final Inventory inventory;
  final bool isNewInventory;

  AddInventoryScreen({this.isNewInventory = false, this.inventory});

  @override
  _AddInventoryScreenState createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  String selectedChips = "";
  TextEditingController nameController,
      originalPriceController,
      sellingPriceController,
      descriptionController,
      quantityController;
  String inventoryImageUrl;

  Map inputFields = {
    "name": "",
    "originalPrice": "",
    "sellingPrice": "",
    "description": "",
    "quantity": ""
  };

  @override
  void initState() {
    super.initState();
    if (widget.isNewInventory) {
      nameController = TextEditingController();
      originalPriceController = TextEditingController();
      sellingPriceController = TextEditingController();
      descriptionController = TextEditingController();
      quantityController = TextEditingController();
      selectedChips = "";
      inventoryImageUrl = null;
    } else {
      nameController = TextEditingController(text: widget.inventory.name);
      originalPriceController = TextEditingController(
          text: widget.inventory.originalPrice.toString());
      sellingPriceController =
          TextEditingController(text: widget.inventory.sellingPrice.toString());
      descriptionController =
          TextEditingController(text: widget.inventory.description);
      quantityController =
          TextEditingController(text: widget.inventory.inStock.toString());
      selectedChips = widget.inventory.category;
      inventoryImageUrl = widget.inventory.imageUrl;
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
          headerText('Name and Category'),
          Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0),
            child: CustomTextField(
              hintText: 'Product Name',
              controller: nameController,
              obscureText: false,
              onChanged: (val) {
                inputFields['name'] = val;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
            child: ChipsComponent(
              itemList: [
                "Mobile Phones",
                "Headphones",
                "Laptops",
                "Accessories"
              ],
              selectedChips: selectedChips,
              onChanged: (value) {
                setState(() {
                  selectedChips = value;
                });
              },
            ),
          ),
          headerText('Product Photo'),
          ImageSelectionWidget(
            existingUrl: inventoryImageUrl,
            onUserImageSet: (imgUrl) {
              inventoryImageUrl = imgUrl;
            },
          ),
          headerText('Pricing'),
          priceFields(),
          Container(
            padding: EdgeInsets.only(top: 20, left: 24, right: 24),
            child: HeaderAndSubHeader(
              headerText: 'Item Description',
              subHeaderText:
                  'You must provide a proper description of the item details',
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: CustomTextField(
              hintText: 'Description',
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              obscureText: false,
              onChanged: (val) {
                inputFields['description'] = val;
              },
            ),
          ),
          headerText('Quantity in Stock'),
          Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
            child: CustomTextField(
              hintText: 'Items in Stock',
              controller: quantityController,
              obscureText: false,
              onChanged: (val) {
                inputFields['quantity'] = val;
              },
            ),
          ),
          widget.isNewInventory
              ? Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: addInventoryMutationComponent(),
                )
              : Container(
                  padding: EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      deleteInventoryMutationComponent(),
                      updateInventoryMutationComponent(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget deleteInventoryButton(RunMutation runMutation) {
    return TertiaryButton(
      text: 'Delete Item',
      onPressed: () {
        runMutation({
          "inventoryId": widget.inventory.id,
        });
      },
    );
  }

  Widget addItemButton(RunMutation runMutation) {
    final appState = Provider.of<AppState>(context);
    return PrimaryButtonWidget(
      buttonText: 'Add Item',
      onPressed: () {
        runMutation(
          {
            "name": nameController.text,
            "category": selectedChips,
            "originalPrice": double.parse(originalPriceController.text),
            "sellingPrice": double.parse(sellingPriceController.text),
            "description": descriptionController.text,
            "inStock": double.parse(quantityController.text),
            "imageUrl": inventoryImageUrl,
            "address": {
              "addressLine": appState.getVendorAddressLine,
              "city": appState.getVendorCity,
            }
          },
        );
      },
    );
  }

  Widget saveChangesButton(RunMutation runMutation) {
    final appState = Provider.of<AppState>(context);
    return PrimaryButtonWidget(
      buttonText: 'Save Changes',
      onPressed: () {
        runMutation({
          "inventoryId": widget.inventory.id,
          "name": nameController.text,
          "category": selectedChips,
          "originalPrice": double.parse(originalPriceController.text),
          "sellingPrice": double.parse(sellingPriceController.text),
          "description": descriptionController.text,
          "inStock": double.parse(quantityController.text),
          "imageUrl": inventoryImageUrl,
          "address": {
            "addressLine": appState.getVendorAddressLine,
            "city": appState.getVendorCity,
          }
        });
      },
    );
  }

  Widget priceFields() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: CustomTextField(
                  hintText: 'Original Price (MRP)',
                  controller: originalPriceController,
                  obscureText: false,
                  onChanged: (val) {
                    inputFields['originalPrice'] = val;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 2,
                child: CustomTextField(
                  hintText: 'Selling Price (for sale)',
                  controller: sellingPriceController,
                  obscureText: false,
                  onChanged: (val) {
                    inputFields['sellingPrice'] = val;
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Rs. " + originalPriceController.text,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                  color: PALE_RED_COLOR,
                ),
              ),
              Text(
                "Rs. " + sellingPriceController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: PRIMARY_COLOR,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  'Enter the prices to see how they appear',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: GREY_COLOR,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget headerText(text) {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.only(top: 42.0, left: 22.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
          ),
          Container(width: 20),
          Text(
            widget.isNewInventory ? 'Add new item' : 'Edit item',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }

  Widget addInventoryMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: addNewInventoryMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return addItemButton(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['addNewInventory']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget updateInventoryMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: updateInventoryMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return saveChangesButton(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['updateInventory']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget deleteInventoryMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: deleteInventoryMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutaion, result) {
        return deleteInventoryButton(runMutaion);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['deleteInventory']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
