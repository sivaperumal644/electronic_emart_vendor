import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class FormProcessHeader extends StatelessWidget {
  final String title;
  final int currentScreen;
  FormProcessHeader({this.title, this.currentScreen});

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
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ScreenIndicator(
                      color: PRIMARY_COLOR.withOpacity(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ScreenIndicator(
                      color: PRIMARY_COLOR.withOpacity(0.25),
                    ),
                  ),
                  ScreenIndicator(
                    color: PRIMARY_COLOR.withOpacity(0.25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Step $currentScreen/3: $title',
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
