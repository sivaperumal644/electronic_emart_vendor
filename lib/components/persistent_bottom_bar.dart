import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class PersistentBottomBar extends StatelessWidget {
  final Function tertiaryOnPressed;
  final Function primaryOnPressed;
  final bool isPrimaryClickable;

  PersistentBottomBar(
      {this.tertiaryOnPressed, this.primaryOnPressed, this.isPrimaryClickable});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: PRIMARY_COLOR.withOpacity(0.3), width: 1),
          ),
          color: WHITE_COLOR),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TertiaryButton(
              onPressed: tertiaryOnPressed,
              text: 'Back',
            ),
            PrimaryButtonWidget(
              buttonText: 'Next',
              onPressed: isPrimaryClickable ? primaryOnPressed : null,
            )
          ],
        ),
      ),
    );
  }
}
