import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:flutter/material.dart';

class ScreenIndicatorRow extends StatelessWidget {
  final List<Color> colors;
  const ScreenIndicatorRow({this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(color: colors[0]),
        ),
        Container(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(color: colors[1]),
        ),
        Container(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(color: colors[2]),
        ),
        ScreenIndicator(color: colors[3])
      ],
    );
  }
}