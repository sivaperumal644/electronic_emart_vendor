import 'package:electronic_emart_vendor/components/screen_indicator_row.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeSeenActiveOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PRIMARY_COLOR.withOpacity(0.35),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order ID. 3454',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs. 3,45,560',
                    style: TextStyle(
                      fontSize: 16,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24, 4, 24, 0),
              child: Text(
                'Apple iPhone X, and 2 more items',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16, right: 24, bottom: 4),
              child: ScreenIndicatorRow(
                colors: [
                  PRIMARY_COLOR,
                  PRIMARY_COLOR,
                  PRIMARY_COLOR.withOpacity(0.5),
                  PRIMARY_COLOR.withOpacity(0.5)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Received',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Credit/Debit Card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  Text(
                    'Waiting processing and pickup',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 16),
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: PRIMARY_COLOR.withOpacity(0.35),
            ),
            Container(
              margin: EdgeInsets.only(right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Manage this order',
                    style: TextStyle(
                      fontSize: 14,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
