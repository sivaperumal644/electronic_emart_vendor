import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final IconData icon;

  PrimaryButtonWidget({this.buttonText, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: PRIMARY_COLOR,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$buttonText',
            style: TextStyle(
                color: WHITE_COLOR,
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
          ),
          if (icon != null) ...[
            Container(margin: EdgeInsets.only(left: 9)),
            Icon(
              icon,
              color: WHITE_COLOR,
            )
          ],
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
