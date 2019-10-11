import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeActiveOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
          color: WHITE_COLOR,
          boxShadow: [
            BoxShadow(
              color: PRIMARY_COLOR.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PRIMARY_COLOR, width: 2)),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: WHITE_COLOR,
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
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Text(
                  'Credit/Debit Card (Payment Complete)',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 16),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: PRIMARY_COLOR.withOpacity(0.35),
              ),
              Center(
                child: Text(
                  'ACCEPT OR REJECT THIS ORDER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
