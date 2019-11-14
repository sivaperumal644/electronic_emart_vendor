import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class StatisticsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PRIMARY_COLOR),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(12),
              ),
              color: PRIMARY_COLOR,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  '45',
                  style: TextStyle(
                    color: WHITE_COLOR,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Orders',
                  style: TextStyle(
                    color: WHITE_COLOR.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(top: 4.0)),
          Text(
            'Totalling',
            style: TextStyle(
              fontSize: 12,
              color: PRIMARY_COLOR.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '₹ 50,000',
            style: TextStyle(
              fontSize: 14,
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            'TODAY',
            style: TextStyle(
              fontSize: 12,
              color: PRIMARY_COLOR.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
