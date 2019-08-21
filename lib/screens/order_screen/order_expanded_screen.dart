import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/order_screen/order_details_screen.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

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
          Expanded(
            child: ListView(
              children: <Widget>[
                orderListWidget(),
                orderListWidget(),
                orderListWidget(),
                orderListWidget(),
                orderListWidget(),
                orderListWidget(),
              ],
            ),
          )
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

  Widget orderListWidget() {
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
                    'Order ID. 3452',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs. 3,45,560',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  )
                ],
              ),
              Text(
                'Apple iPhone X, and 2 more items',
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
                    'Delivered',
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
                    'Cash on Delivery (Paid)',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  ),
                  Text(
                    'Order complete',
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
