import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
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
              'Cash on Delivery',
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
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: orderItemsRow(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: orderItemsRow(),
        ),
        orderItemsRow(),
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
            'Mr. Vineesh',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          '10/45, ABC Street, Lorem Ipsum,',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          'Coimbatore - 456067',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          '+91 8898896969',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget orderItemsRow() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Image.asset('assets/images/place_holder.png'),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Apple iPhone X - 64 GB, Rose Gold',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BLACK_COLOR,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Rs. 194,500',
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
}

Widget itemHeaderText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        'Order ID. 3456',
        style: TextStyle(
          color: BLACK_COLOR,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Rs. 3,45,670',
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
