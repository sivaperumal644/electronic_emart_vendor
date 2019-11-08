import 'package:electronic_emart_vendor/components/inventory_list_item.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class OutOfStockScreen extends StatefulWidget {
  @override
  _OutOfStockScreenState createState() => _OutOfStockScreenState();
}

class _OutOfStockScreenState extends State<OutOfStockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(height: 24),
          appBar(),
          Container(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: isStockOfInventoryEmpty(),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 24, 20),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            ),
          ),
          Container(width: 24),
          Text(
            'Out of stock Inventory list',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  Widget outOfStockList(List<Inventory> inventory) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        return InvetoryListItem(
          inventoryItem: inventory[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddInventoryScreen(
                  isNewInventory: false,
                  inventory: inventory[index],
                ),
              ),
            );
          },
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
          return outOfStockList(listStockAvailble);
        }
        return Container(
          child: Text('No out of stock Inventory.'),
        );
      },
    );
  }
}
