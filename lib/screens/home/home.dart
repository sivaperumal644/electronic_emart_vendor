import 'package:electronic_emart_vendor/components/amount_to_pay_widget.dart';
import 'package:electronic_emart_vendor/components/home_seen_active_orders.dart';
import 'package:electronic_emart_vendor/components/home_unseen_active_orders.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/modals/User.dart';
import 'package:electronic_emart_vendor/screens/inventory/get_all_inventory_graphql.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:electronic_emart_vendor/screens/order_history/order_history_graphql.dart';
import 'package:electronic_emart_vendor/screens/out_of_stock_screen/out_of_stock_screen.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              'Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: getAllOrdersMutationComponent()),
        ],
      ),
    );
  }

  Widget emptyInventoryContainer(
      headerText, subHeaderText, isInventoryEmpty, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: isInventoryEmpty
                ? [PRIMARY_COLOR.withOpacity(0.85), PRIMARY_COLOR]
                : [Colors.red.shade900.withOpacity(0.8), Colors.red.shade900],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(16),
          color: isInventoryEmpty ? PRIMARY_COLOR : ORANGE_COLOR,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: isInventoryEmpty
                  ? PRIMARY_COLOR.withOpacity(0.5)
                  : PALE_RED_COLOR.withOpacity(0.5),
              offset: Offset(2.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    headerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: WHITE_COLOR,
                    ),
                  ),
                  Icon(
                    FeatherIcons.shoppingCart,
                    size: 44,
                    color: WHITE_COLOR.withOpacity(0.25),
                  )
                ],
              ),
              Container(margin: EdgeInsets.only(top: 10)),
              Text(
                subHeaderText,
                style: TextStyle(
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mainList(List<Order> listSeen, List<Order> listUnSeen) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        isInventoryEmpty(),
        getVendorInfo(),
        Container(
          margin: EdgeInsets.only(left: 24, top: 8),
          child: Text(
            'Active Orders',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(height: 16),
        if (listSeen.length == 0 && listUnSeen.length == 0)
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Text(
                'No active orders now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: GREY_COLOR,
                ),
              ),
            ),
          ),
        seenList(listSeen),
        unSeenList(listUnSeen),
      ],
    );
  }

  Widget seenList(List<Order> orders) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return HomeSeenActiveOrders(
          orders: orders[index],
          cartItemInput: orders[index].cartItems,
        );
      },
    );
  }

  Widget unSeenList(List<Order> orders) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return HomeUnSeenActiveOrders(
          orders: orders[index],
          cartItemInput: orders[index].cartItems,
        );
      },
    );
  }

  Widget getAllOrdersMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorOrdersQuery,
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
            result.data['getVendorOrders']['orders'] != null) {
          if (result.data['getVendorOrders']['orders'].length == 0)
            return mainList([], []);
          List vendorOrderList = result.data['getVendorOrders']['orders'];
          final orders =
              vendorOrderList.map((item) => Order.fromJson(item)).toList();
          final seenOrders = orders
              .where((item) =>
                  item.cartItems[0].itemStatus ==
                      OrderStatuses.PLACED_BY_CUSTOMER &&
                  (item.transactionSuccess == true ||
                      item.paymentMode == "Cash On Delivery"))
              .toList();
          seenOrders.sort((a, b) => a.updatedDate.compareTo(b.updatedDate));
          final unSeenOrders = orders
              .where((item) =>
                  item.cartItems[0].itemStatus ==
                      OrderStatuses.RECEIVED_BY_STORE &&
                  (item.transactionSuccess == true ||
                      item.paymentMode == "Cash On Delivery"))
              .toList();
          unSeenOrders.sort((a, b) => b.updatedDate.compareTo(a.updatedDate));
          return Container(
            height: MediaQuery.of(context).size.height,
            child: mainList(seenOrders, unSeenOrders),
          );
        }
        return Container(
          child: Center(child: Text('No orders found.')),
        );
      },
    );
  }

  Widget isInventoryEmpty() {
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
        if (result.data == null ||
            result.data['getVendorInventory'] == null ||
            result.data['getVendorInventory']['inventory'] == null ||
            result.data['getVendorInventory']['inventory'].length == 0) {
          return emptyInventoryContainer(
              'Your inventory is empty!',
              'You need to add items that you have in stock, to our inventory listing. Tap here to get started.',
              true, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddInventoryScreen(
                  isNewInventory: true,
                ),
              ),
            );
          });
        } else {
          List inventoryList = result.data['getVendorInventory']['inventory'];
          final inventories =
              inventoryList.map((item) => Inventory.fromJson(item)).toList();
          final listStockAvailble =
              inventories.where((inventory) => inventory.inStock < 1).toList();

          if (listStockAvailble.length != 0)
            return emptyInventoryContainer(
                'Some items are out of stock',
                'You have items in your inventory that have no stock left. Tap to manage these items.',
                false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutOfStockScreen(),
                ),
              );
            });
          else
            return Container();
        }
      },
    );
  }

  Widget getVendorInfo() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInfoQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 3,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorInfo']['user'] != null) {
          final user = User.fromJson(result.data['getVendorInfo']['user']);
          return AmountToBePaid(amountToPay: user.amountToPay);
        }
        return Container();
      },
    );
  }
}
