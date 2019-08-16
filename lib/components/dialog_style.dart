import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class DialogStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
      title: Center(
        child: Text(
          'Approval pending',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Your account is waiting for admin approval, and can only be accessed once it is complete.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: PrimaryButtonWidget(
              buttonText: 'Got it',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
