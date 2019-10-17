import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData() {
    return SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    final dataSecond = [
      LinearSales(0, 10),
      LinearSales(1, 30),
      LinearSales(2, 90),
      LinearSales(3, 85),
    ];
    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#0039CA'),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        insideLabelStyleAccessorFn: (_, __) =>
            charts.TextStyleSpec(color: charts.Color.fromHex(code: '#0039CA')),
        outsideLabelStyleAccessorFn: (_, __) =>
            charts.TextStyleSpec(color: charts.Color.fromHex(code: '#0039CA')),
        data: data,
      ),
      charts.Series<LinearSales, int>(
        id: 'Count',
        colorFn: (_, __) => charts.Color.fromHex(code: '#0039CA'),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        insideLabelStyleAccessorFn: (_, __) =>
            charts.TextStyleSpec(color: charts.Color.fromHex(code: '#0039CA')),
        outsideLabelStyleAccessorFn: (_, __) =>
            charts.TextStyleSpec(color: charts.Color.fromHex(code: '#0039CA')),
        data: dataSecond,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
