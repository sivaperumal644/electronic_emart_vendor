import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class TeritoryButton extends StatelessWidget {
  final String text;

  TeritoryButton({this.text});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: WHITE_COLOR,
      onPressed: () {},
      child: Text(
        "$text",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: PRIMARY_COLOR),
      ),
    );
  }
}
