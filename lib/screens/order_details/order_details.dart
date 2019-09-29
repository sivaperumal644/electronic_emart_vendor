import 'package:electronic_emart_vendor/components/order_details.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order orders;
  final List<CartItemInput> cartItemInput;

  const OrderDetailsScreen({this.orders, this.cartItemInput});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FeatherIcons.arrowLeft,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 16, 24, 42),
            child: OrderDetails(
              order: orders,
              cartItemInput: cartItemInput,
            ),
          ),
        ],
      ),
    );
  }
}
