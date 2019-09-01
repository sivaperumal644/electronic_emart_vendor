import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_details/order_details.dart';
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
  String selectedChips = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          appBar(),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 24),
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

  Widget orderListComponent(List<Order> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Text('No orders found'),
          ),
        );
        return OrderListWidget(orderItems: orders[index]);
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
          pollInterval: 5),
      builder: (QueryResult result, {VoidCallback refetch}) {
        print(result.errors);
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorOrders']['orders'] != null) {
          List vendorOrderList = result.data['getVendorOrders']['orders'];
          final orders =
              vendorOrderList.map((item) => Order.fromJson(item)).toList();
          return Container(
              height: MediaQuery.of(context).size.height,
              child: orderListComponent(orders));
        }
        return Container();
      },
    );
  }
}

class OrderListWidget extends StatelessWidget {
  final Order orderItems;
  OrderListWidget({this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: GREY_COLOR.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    orderItems.id,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    orderItems.totalPrice.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  )
                ],
              ),
              Text(
                'apple iphone x',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                  ],
                ),
              ),
              Container(padding: EdgeInsets.only(top: 6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    orderItems.status,
                    style: TextStyle(
                      color: GREEN_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    orderItems.paymentMode,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  ),
                  Text(
                    orderItems.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
