import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double buttonHeight, buttonWidth;

  SecondaryButton(
      {this.buttonText, this.onPressed, this.buttonHeight, this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      child: OutlineButton(
        onPressed: onPressed,
        borderSide: BorderSide(color: PRIMARY_COLOR, width: 1.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 16,
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
