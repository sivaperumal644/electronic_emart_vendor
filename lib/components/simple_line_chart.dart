import 'package:charts_flutter/flutter.dart' as charts;
import 'package:electronic_emart_vendor/modals/OrderStats.dart';
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  factory SimpleLineChart.withSampleData(
      List<OrderStats> orderStatsList, bool isAmountGraph) {
    return SimpleLineChart(
      _createSampleData(orderStatsList, isAmountGraph),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(seriesList, animate: animate, behaviors: []);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(
      List<OrderStats> orderStatsList, bool isAmountGraph) {
    List<TimeSeriesSales> data = [];

    for (int i = 0; i < orderStatsList.length; i++) {
      data.add(TimeSeriesSales(DateTime.parse(orderStatsList[i].date),
          orderStatsList[i].orderCount));
    }

    List<TimeSeriesSales> data2 = [];
    for (int i = 0; i < orderStatsList.length; i++) {
      data2.add(TimeSeriesSales(DateTime.parse(orderStatsList[i].date),
          orderStatsList[i].totalAmount));
    }

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => isAmountGraph
            ? charts.Color.fromHex(code: '#8B0000')
            : charts.Color.fromHex(code: '#0039CA'),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: isAmountGraph ? data2 : data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}
