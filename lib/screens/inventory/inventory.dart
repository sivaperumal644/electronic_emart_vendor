import 'package:electronic_emart_vendor/components/drop_down_widget.dart';
import 'package:electronic_emart_vendor/components/inventory_list_item.dart';
import 'package:electronic_emart_vendor/components/secondary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:electronic_emart_vendor/screens/inventory_detail_screen/inventory_detail_screen.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:electronic_emart_vendor/screens/out_of_stock_screen/out_of_stock_screen.dart';
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
          Container(
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              boxShadow: [
                BoxShadow(
                  color: GREY_COLOR,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                searchBar(),
                filterBar(),
              ],
            ),
          ),
          isStockOfInventoryEmpty(),
          getAllVendorQueryComponent(),
        ],
      ),
    );
  }

  Widget outOfStockWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 8, 24, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning,
                color: LIGHT_ORANGE_COLOR,
              ),
              Container(width: 8),
              Text(
                'Some items are out of stock.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: LIGHT_ORANGE_COLOR,
                ),
              ),
            ],
          ),
          SecondaryButton(
            buttonText: 'Manage',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutOfStockScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget inventoryListWidget(List<Inventory> inventories) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: inventories.length,
      itemBuilder: (context, index) {
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
              builder: (context) => InventortDetailScreen(inventory: inventory),
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
      padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 20.0),
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
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading)
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
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
          return Expanded(
            child: inventoryListWidget(inventories),
          );
        }
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
      },
    );
  }

  Widget isStockOfInventoryEmpty() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInventoryQuery,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.data != null &&
            result.data['getVendorInventory'] != null &&
            result.data['getVendorInventory']['inventory'] != null) {
          List inventoryList = result.data['getVendorInventory']['inventory'];
          final inventories =
              inventoryList.map((item) => Inventory.fromJson(item)).toList();
          final listStockAvailble =
              inventories.where((inventory) => inventory.inStock < 1).toList();

          if (listStockAvailble.length != 0)
            return outOfStockWidget();
          else
            return Container();
        }
        return Container();
      },
    );
  }
}
