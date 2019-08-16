import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/teritory_button.dart';
import 'package:flutter/material.dart';

class PersistentBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TeritoryButton(
            text: 'Back',
          ),
          PrimaryButtonWidget(
            buttonText: 'Next',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
