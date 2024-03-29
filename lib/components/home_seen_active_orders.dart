import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_details/order_details.dart';
import 'package:flutter/material.dart';

class HomeSeenActiveOrders extends StatefulWidget {
  final Order orders;
  final List<CartItemInput> cartItemInput;
  const HomeSeenActiveOrders({
    this.orders,
    this.cartItemInput,
  });

  @override
  _HomeSeenActiveOrdersState createState() => _HomeSeenActiveOrdersState();
}

class _HomeSeenActiveOrdersState extends State<HomeSeenActiveOrders> {
  @override
  Widget build(BuildContext context) {
    final cartItemLength = widget.cartItemInput.length;
    String cartItemNames;
    if (cartItemLength == 2)
      cartItemNames = widget.cartItemInput[0].inventory.name +
          ', ' +
          widget.cartItemInput[1].inventory.name;
    else if (cartItemLength == 1)
      cartItemNames = widget.cartItemInput[0].inventory.name;
    else
      cartItemNames = widget.cartItemInput[0].inventory.name +
          ', ' +
          widget.cartItemInput[1].inventory.name +
          ' and ${cartItemLength - 2} more.';
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                  orders: widget.orders,
                  cartItemInput: widget.cartItemInput,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Order ID. BS' + widget.orders.orderNo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '₹ ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: PRIMARY_COLOR,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.orders.totalPrice.toString(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 4, 24, 0),
                child: Text(
                  cartItemNames,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Text(
                  widget.orders.paymentMode,
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
