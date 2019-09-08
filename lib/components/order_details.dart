import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final List<CartItemInput> cartItemInput;
  final Order order;
  OrderDetails({this.cartItemInput, this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        itemHeaderText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              order.paymentMode,
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 42.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ORDER STATUS',
                style: TextStyle(
                  fontSize: 12,
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              screenIndicatorRow(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Text(
            'Waiting for store confirmation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'We’re waiting for the store to confirm your order. Once confirmed, your order will be packaged and shipped.',
            style: TextStyle(
              fontSize: 14,
              color: BLACK_COLOR,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 42.0),
          child: Text(
            'ITEMS IN ORDER',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        displayOrderItems(),
        Padding(
          padding: const EdgeInsets.only(top: 44.0),
          child: Text(
            'SHIPPING ADDRESS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Mr. ' + order.address['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          order.address['addressLine'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          order.address['landmark'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          order.address['city'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          order.address['phoneNumber'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget displayOrderItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: cartItemInput.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: orderItemsRow(cartItemInput[index]),
        );
      },
    );
  }

  Widget orderItemsRow(CartItemInput cartItemInputDetails) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: GREY_COLOR.withOpacity(0.15)),
      child: Row(
        children: <Widget>[
          Image.network(cartItemInputDetails.imageUrl,
              fit: BoxFit.cover, width: 55, height: 55),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cartItemInputDetails.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BLACK_COLOR,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Rs. ' + cartItemInputDetails.sellingPrice.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemHeaderText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Order ID. ' + order.orderNo,
          style: TextStyle(
            color: BLACK_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Rs. ' + order.totalPrice.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        )
      ],
    );
  }

  Widget screenIndicatorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(
            color: PRIMARY_COLOR,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(
            color: PRIMARY_COLOR.withOpacity(0.25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ScreenIndicator(
            color: PRIMARY_COLOR.withOpacity(0.25),
          ),
        ),
        ScreenIndicator(
          color: PRIMARY_COLOR.withOpacity(0.25),
        )
      ],
    );
  }
}
