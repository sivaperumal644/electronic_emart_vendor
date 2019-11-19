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

  String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 45)),
          headerText('Order Stats', TextAlign.center),
          Container(height: 16),
          dateShowingString(),
          Expanded(child: getOrderStatsComponent()),
        ],
      ),
    );
  }

  Widget orderStatsMainList(List<OrderStats> orderStats, income, orders) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        graphHeader('Order Graph', 'Showing total orders per day'),
        Container(
          width: 360,
          height: 300,
          margin: EdgeInsets.all(24.0),
          child: SimpleLineChart.withSampleData(orderStats, false),
        ),
        dividerLine(),
        Container(height: 16),
        graphHeader('Income Graph', 'Showing total income of each day'),
        Container(
          width: 360,
          height: 300,
          margin: EdgeInsets.all(24.0),
          child: SimpleLineChart.withSampleData(orderStats, true),
        ),
        dividerLine(),
        Container(height: 16),
        incomeTextWidget('TOTAL INCOME', 0.35, 16.0, ''),
        incomeTextWidget('${income.toString()}', 1.0, 36.0, '₹ '),
        Container(
          margin: EdgeInsets.only(left: 24.0),
          child: headerText('${orders.toString()} orders', TextAlign.start),
        ),
        Container(height: 16),
        dividerLine(),
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
    );
  }

  Widget dividerLine() {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: 10.0, bottom: 3),
      color: PRIMARY_COLOR.withOpacity(0.35),
    );
  }

  Widget graphHeader(title, subTitle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 2),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 16,
              color: GREY_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateShowingString() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24),
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

  Widget incomeTextWidget(
      String text, double opacity, double size, String symbol) {
    return Container(
      margin: EdgeInsets.only(left: 24.0),
      child: Row(
        children: <Widget>[
          Text(
            symbol,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: PRIMARY_COLOR.withOpacity(opacity),
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: PRIMARY_COLOR.withOpacity(opacity),
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
        fetchPolicy: FetchPolicy.noCache,
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
        if (result.loading) return Center(child: CupertinoActivityIndicator());
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
          totalIncome = totalIncome - (0.11*totalIncome);
          return orderStatsMainList(
              getOrderStatsList, totalIncome, totalOrders);
        }
        return Container();
      },
    );
  }
}
