import 'package:electronic_emart_vendor/components/screen_indicator.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          itemHeaderText(),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Apple iPhone X, and 2 more items',
              style: TextStyle(color: BLACK_COLOR, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: screenIndicatorRow(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Placed',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              )
            ],
          ),
          cashItemRow()
        ],
      ),
    );
  }

  Widget cashItemRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Cash on Delivery',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        ),
        Text(
          'waiting for store confirmation',
          style: TextStyle(
            color: BLACK_COLOR,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        )
      ],
    );
  }
}
