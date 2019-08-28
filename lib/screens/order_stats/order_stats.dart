import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/components/simple_line_chart.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/order_history/order_history.dart';
import 'package:flutter/material.dart';

class OrderStatScreen extends StatefulWidget {
  @override
  _OrderStatScreenState createState() => _OrderStatScreenState();
}

class _OrderStatScreenState extends State<OrderStatScreen> {
  String selectedChips = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 25)),
          headerText('Order Stats', TextAlign.center),
          Container(
            width: 360,
            height: 300,
            margin: EdgeInsets.all(24.0),
            child: SimpleLineChart.withSampleData(),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 10),
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
          incomeTextWidget('ALL TIME INCOME', 0.35, 16.0),
          incomeTextWidget('Rs. 56,000', 1.0, 36.0),
          Container(
            margin: EdgeInsets.only(right: 24.0),
            child: headerText('45 orders', TextAlign.end),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(top: 30.0, bottom: 5),
            color: PRIMARY_COLOR.withOpacity(0.35),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderExpandedScreen(),
                ),
              );
            },
            child: SettingsOption(
              title: 'Order History',
              color: BLACK_COLOR,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {},
              child: SettingsOption(
                title: 'Download your data',
                color: BLACK_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget incomeTextWidget(String text, double opacity, double size) {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: TextStyle(
          color: PRIMARY_COLOR.withOpacity(opacity),
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget headerText(text, textAlign) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: BLACK_COLOR,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}