import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class FormProcessHeader extends StatelessWidget {
  final int activeIndicators, totalIndicators;
  final List titleLists = [
    'Account Credentials',
    'Store Details',
    'Bank & Paytm Details',
    'Upload Documents'
  ];

  FormProcessHeader({
    this.activeIndicators,
    this.totalIndicators,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Registration',
                style: TextStyle(
                  fontSize: 36,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(children: <Widget>[
                for (int i = 0; i < totalIndicators; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ScreenIndicator(
                      color: activeIndicators + 1 > i
                          ? PRIMARY_COLOR.withOpacity(1)
                          : PRIMARY_COLOR.withOpacity(0.25),
                    ),
                  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Step ${activeIndicators + 1}/$totalIndicators: ${titleLists[activeIndicators]}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
