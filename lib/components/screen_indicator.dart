import 'package:flutter/material.dart';

class ScreenIndicator extends StatelessWidget {
  final color;
  ScreenIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 4,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
    );
  }
}
