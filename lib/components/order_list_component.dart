import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_details/order_details.dart';
import 'package:flutter/material.dart';

class OrderListWidget extends StatelessWidget {
  final Order orders;
  final List<CartItemInput> cartItemInput;

  OrderListWidget({this.orders, this.cartItemInput});
  @override
  Widget build(BuildContext context) {
    int cartItemLength = cartItemInput.length;
    String cartItemNames;
    if (cartItemLength == 2)
      cartItemNames = cartItemInput[0].name + ', ' + cartItemInput[1].name;
    else if (cartItemLength == 1)
      cartItemNames = cartItemInput[0].name;
    else
      cartItemNames = cartItemInput[0].name +
          ', ' +
          cartItemInput[1].name +
          ' and ${cartItemLength - 2} more.';
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                orders: orders,
                cartItemInput: cartItemInput,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: GREY_COLOR.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order ID. ' + orders.orderNo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs. ' + orders.totalPrice.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  )
                ],
              ),
              Text(
                cartItemNames,
                style: TextStyle(fontSize: 16),
              ),
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: ScreenIndicator(color: GREEN_COLOR),
                    ),
                  ],
                ),
              ),
              Container(padding: EdgeInsets.only(top: 6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    orders.status,
                    style: TextStyle(
                      color: GREEN_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    orders.paymentMode,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  ),
                  Text(
                    'Order under processing',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
