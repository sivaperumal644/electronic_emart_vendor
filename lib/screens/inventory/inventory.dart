import 'package:electronic_emart_vendor/components/drop_down_widget.dart';
import 'package:electronic_emart_vendor/components/inventory_list_item.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

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
              builder: (context) => AddInventoryScreen(isNewInventory: true),
            ),
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
                getAllVendorQueryComponent(),
                Container(padding: EdgeInsets.only(bottom: 60))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inventoryListWidget(List<Inventory> inventories) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: inventories.length + 1,
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
        if (index == inventories.length) {
          return Container(height: 320);
        }
        return inventoryItem(inventories[index]);
      },
    );
  }

  Widget inventoryItem(Inventory inventory) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
      child: InvetoryListItem(
        inventoryItem: inventory,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInventoryScreen(
                inventory: inventory,
                isNewInventory: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchBar() {
    final appState = Provider.of<AppState>(context);
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
              obscureText: false,
              onChanged: (text) {
                appState.setSearchText(text);
              },
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
            itemList: [
              'Name (A-Z)',
              'Name (Z-A)',
              'Price (low to high)',
              'Price (high to low)',
            ],
          ),
        ],
      ),
    );
  }

  Widget getAllVendorQueryComponent() {
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
          if (itemValue == 'Name (A-Z)')
            inventories.sort((a, b) => a.name.compareTo(b.name));
          else if (itemValue == 'Name (Z-A)')
            inventories.sort((a, b) => b.name.compareTo(a.name));
          else if (itemValue == 'Price (low to high)')
            inventories
                .sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
          else if (itemValue == 'Price (high to low)')
            inventories
                .sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
          return Container(
              height: MediaQuery.of(context).size.height,
              child: inventoryListWidget(inventories));
        }
        return Container();
      },
    );
  }
}
