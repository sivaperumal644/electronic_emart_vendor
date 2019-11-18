import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class AmountToBePaid extends StatelessWidget {
  final double amountToPay;

  const AmountToBePaid({this.amountToPay});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        border: Border.all(color: PRIMARY_COLOR),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PRIMARY_COLOR,
            blurRadius: 5.0,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: EdgeInsets.all(20),
        color: PRIMARY_COLOR.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pending payment to you: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '₹ ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: PRIMARY_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: (amountToPay - (11 / 100 * amountToPay)).toString(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
