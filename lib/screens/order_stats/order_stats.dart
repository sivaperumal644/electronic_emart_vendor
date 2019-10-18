import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/components/simple_line_chart.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/OrderStats.dart';
import 'package:electronic_emart_vendor/screens/download_your_data/download_your_data_screen.dart';
import 'package:electronic_emart_vendor/screens/order_history/order_history.dart';
import 'package:electronic_emart_vendor/screens/order_stats/order_stats_graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class OrderStatScreen extends StatefulWidget {
  @override
  _OrderStatScreenState createState() => _OrderStatScreenState();
}

class _OrderStatScreenState extends State<OrderStatScreen> {
  String selectedChips = "";
  String startDate = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-01";
  String endDate = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString();

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
          dateShowingString(),
          incomeTextWidget('Total INCOME', 0.35, 16.0),
          getOrderStatsComponent(),
          Container(
            height: 1,
            margin: EdgeInsets.only(top: 30.0, bottom: 3),
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
            margin: EdgeInsets.only(top: 3),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadYourDataScreen(),
                  ),
                );
              },
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

  Widget displayOrderStats(income, orders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        incomeTextWidget('Rs. ${income.toString()}', 1.0, 36.0),
        Container(
          margin: EdgeInsets.only(right: 24.0),
          child: headerText('${orders.toString()} orders', TextAlign.end),
        ),
      ],
    );
  }

  Widget dateShowingString() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Showing from',
            style: TextStyle(
              color: GREY_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.parse(startDate),
                firstDate: DateTime(2019),
                lastDate: DateTime.now(),
              );
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
              setState(() {
                startDate = formattedDate;
              });
            },
            child: Chip(
              label: Text(
                startDate,
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: PRIMARY_COLOR.withOpacity(0.15),
            ),
          ),
          Text(
            'to',
            style: TextStyle(
              color: GREY_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.parse(endDate),
                firstDate: DateTime.parse(startDate),
                lastDate: DateTime.now(),
              );
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
              setState(() {
                endDate = formattedDate;
              });
            },
            child: Chip(
              label: Text(
                endDate,
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: PRIMARY_COLOR.withOpacity(0.15),
            ),
          ),
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

  Widget getOrderStatsComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: orderStatsQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        variables: {
          'startDate': startDate,
          'endDate': endDate,
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        //if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getOrderStats'] != null) {
          List orderStats = result.data['getOrderStats'];
          final getOrderStatsList =
              orderStats.map((item) => OrderStats.fromJson(item)).toList();
          double totalIncome = 0;
          int totalOrders = 0;
          for (int i = 0; i < getOrderStatsList.length; i++) {
            totalIncome = totalIncome + getOrderStatsList[i].totalAmount;
            totalOrders = totalOrders + getOrderStatsList[i].orderCount.toInt();
          }
          return displayOrderStats(totalIncome, totalOrders);
        }
        return Container();
      },
    );
  }
}
