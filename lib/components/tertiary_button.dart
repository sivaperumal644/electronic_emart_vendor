import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  TertiaryButton({this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: WHITE_COLOR,
      onPressed: onPressed,
      child: Text(
        "$text",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: PRIMARY_COLOR),
      ),
    );
  }
}
