import 'package:electronic_emart_vendor/components/order_details.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 24, top: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(FeatherIcons.arrowLeft, color: PRIMARY_COLOR),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 16, 24, 42),
            child: OrderDetails(),
          ),
        ],
      ),
    );
  }
}
