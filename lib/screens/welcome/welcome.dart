import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/nav_screens.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 32)),
                Icon(
                  FeatherIcons.checkCircle,
                  color: PRIMARY_COLOR,
                  size: 115,
                ),
                Container(margin: EdgeInsets.only(top: 24)),
                Text(
                  'Welcome aboard!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 36,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 40)),
                contentText(
                    'Congratulations, your registration has been approved and completed.'),
                Container(margin: EdgeInsets.only(top: 16)),
                contentText(
                    'You can start your business on our platform by following these simple steps:'),
                Container(margin: EdgeInsets.only(top: 50)),
                stepsText('1. Fill up the inventory',
                    'Add all the items you have for sale.'),
                Container(margin: EdgeInsets.only(top: 16)),
                stepsText('2. Wait for orders to come in',
                    'Our staff will process the order for you'),
                Container(margin: EdgeInsets.only(top: 16)),
                stepsText('3. Update inventory with new items',
                    'Keep your listing up to date by adding and featuring new items'),
                Container(margin: EdgeInsets.only(top: 30)),
                Text(
                  'Please feel free to contact us anytime.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: GREY_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 130.0))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PersistentBottomBar(
              tertiaryText: 'Skip',
              primaryText: 'Go to inventory',
              tertiaryOnPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => NavigateScreens()),
                );
              },
              primaryOnPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigateScreens(selectedIndex: 1),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget contentText(content) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget stepsText(headerText, subHeaderText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headerText,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            subHeaderText,
            style: TextStyle(
              color: GREY_COLOR,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
