import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isRed;

  TertiaryButton({
    this.text,
    this.onPressed,
    this.isRed = false,
  });
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: WHITE_COLOR,
      onPressed: onPressed,
      child: Text(
        "$text",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isRed?PALE_RED_COLOR:PRIMARY_COLOR,
        ),
      ),
    );
  }
}
