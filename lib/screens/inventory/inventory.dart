import 'package:electronic_emart_vendor/components/drop_down_widget.dart';
import 'package:electronic_emart_vendor/components/inventory_list_item.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/add_inventory/add_inventory.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String itemValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Items',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(FeatherIcons.plus),
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddInventoryScreen(isNewInventory: true)),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          searchBar(),
          filterBar(),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                  child: InvetoryListItem(
                    currentPrice: 14000,
                    discountPrice: 12000,
                    stock: 'Mobile Phones',
                    stockAvailable: 14,
                    inventoryItem: 'Apple iPhone X - 64 GB / Rose Gold',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddInventoryScreen(isNewInventory: false),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                  child: InvetoryListItem(
                    currentPrice: 14000,
                    discountPrice: 12000,
                    stock: 'Mobile Phones',
                    stockAvailable: 14,
                    inventoryItem: 'Apple iPhone X - 64 GB / Rose Gold',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddInventoryScreen(isNewInventory: false),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                  child: InvetoryListItem(
                    currentPrice: 14000,
                    discountPrice: 12000,
                    stock: 'Mobile Phones',
                    stockAvailable: 14,
                    inventoryItem: 'Apple iPhone X - 64 GB / Rose Gold',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddInventoryScreen(isNewInventory: false),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                  child: InvetoryListItem(
                    currentPrice: 14000,
                    discountPrice: 12000,
                    stock: 'Mobile Phones',
                    stockAvailable: 14,
                    inventoryItem: 'Apple iPhone X - 64 GB / Rose Gold',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddInventoryScreen(isNewInventory: false),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 60),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50),
            width: MediaQuery.of(context).size.width / 1.28,
            child: CustomTextField(
              hintText: 'Search for items',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Icon(FeatherIcons.search, color: PRIMARY_COLOR, size: 24),
          )
        ],
      ),
    );
  }

  Widget filterBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Sort by',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Text('$itemValue'),
          DropDownWidget(
            itemValue: itemValue,
            onChanged: (value) {
              setState(() {
                itemValue = value;
              });
            },
            hint: 'Name (A-Z)',
            itemList: ['first', 'second', 'third'],
          ),
        ],
      ),
    );
  }
}
