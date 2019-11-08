import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/order_list_component.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_history/order_history_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class OrderExpandedScreen extends StatefulWidget {
  @override
  _OrderExpandedScreenState createState() => _OrderExpandedScreenState();
}

class _OrderExpandedScreenState extends State<OrderExpandedScreen> {
  String selectedChips = 'All Time';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          appBar(),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 12),
            child: ChipsComponent(
              itemList: ['All Time', 'This month', 'This year'],
              selectedChips: selectedChips,
              onChanged: (value) {
                setState(() {
                  selectedChips = value;
                });
              },
            ),
          ),
          Expanded(child: getAllOrdersMutationComponent())
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.only(top: 42.0, left: 12.0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
          ),
          Container(width: 20),
          Text(
            'Order History',
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

  Widget orderListComponent(List<Order> orders, bool isActiveOrders) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderListWidget(
          orders: orders[index],
          cartItemInput: orders[index].cartItems,
          isActiveOrders: isActiveOrders,
        );
      },
    );
  }

  Widget mainList(List<Order> activeOrders, List<Order> inactiveOrders) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 24.0),
          child: Text(
            'Active orders',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: activeOrders.isEmpty
              ? Center(
                  child: Text(
                    'No active orders',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: GREY_COLOR,
                    ),
                  ),
                )
              : orderListComponent(activeOrders, true),
        ),
        Container(
          margin: EdgeInsets.only(left: 24.0),
          child: Text(
            'Previous orders',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: inactiveOrders.isEmpty
              ? Center(
                  child: Text(
                    'No previous orders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: GREY_COLOR,
                    ),
                  ),
                )
              : orderListComponent(inactiveOrders, false),
        )
      ],
    );
  }

  Widget getAllOrdersMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorOrdersQuery,
        fetchPolicy: FetchPolicy.noCache,
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
          final activeOrders = orders
              .where((item) =>
                  (item.cartItems[0].itemStatus ==
                          OrderStatuses.RECEIVED_BY_STORE ||
                      item.cartItems[0].itemStatus ==
                          OrderStatuses.PLACED_BY_CUSTOMER) &&
                  (item.transactionSuccess == true ||
                      item.paymentMode == "Cash On Delivery"))
              .toList();
          activeOrders.sort((a, b) => a.updatedDate.compareTo(b.updatedDate));

          final inActiveOrders = orders
              .where((item) =>
                  (item.cartItems[0].itemStatus !=
                          OrderStatuses.RECEIVED_BY_STORE &&
                      item.cartItems[0].itemStatus !=
                          OrderStatuses.PLACED_BY_CUSTOMER) ||
                  (item.transactionSuccess == false &&
                      item.paymentMode != "Cash On Delivery"))
              .toList();
          inActiveOrders.sort((a, b) => b.updatedDate.compareTo(a.updatedDate));
          List<Order> activeOrdersSorted;
          List<Order> inActiveOrdersSorted;
          if (selectedChips == 'All Time') {
            activeOrdersSorted = activeOrders;
            inActiveOrdersSorted = inActiveOrders;
          }
          if (selectedChips == 'This month') {
            activeOrdersSorted = activeOrders
                .where((order) =>
                    (order.updatedDate.month == DateTime.now().month) &&
                    (order.datePlaced.year == DateTime.now().year))
                .toList();
            inActiveOrdersSorted = inActiveOrders
                .where((order) =>
                    (order.updatedDate.month == DateTime.now().month) &&
                    (order.datePlaced.year == DateTime.now().year))
                .toList();
          }
          if (selectedChips == 'This year') {
            activeOrdersSorted = activeOrders
                .where((order) => order.datePlaced.year == DateTime.now().year)
                .toList();
            inActiveOrdersSorted = inActiveOrders
                .where((order) => order.updatedDate.year == DateTime.now().year)
                .toList();
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: mainList(activeOrdersSorted, inActiveOrdersSorted),
          );
        }
        return Container(
          child: Center(child: Text('No orders found.')),
        );
      },
    );
  }
}
