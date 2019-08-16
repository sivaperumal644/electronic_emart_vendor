import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class HeaderAndSubHeader extends StatelessWidget {

  final String headerText;
  final String subHeaderText;

  HeaderAndSubHeader({
    this.headerText,
    this.subHeaderText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headerText,
          style: TextStyle(
            color: BLACK_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subHeaderText,
          style: TextStyle(
            color: GREY_COLOR,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
