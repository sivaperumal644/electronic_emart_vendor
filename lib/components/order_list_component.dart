import 'package:electronic_emart_vendor/components/screen_indicator_row.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_details/order_details.dart';
import 'package:flutter/material.dart';

class OrderListWidget extends StatefulWidget {
  final Order orders;
  final List<CartItemInput> cartItemInput;

  OrderListWidget({this.orders, this.cartItemInput});

  @override
  _OrderListWidgetState createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  @override
  Widget build(BuildContext context) {
    int cartItemLength = widget.cartItemInput.length;
    String cartItemNames;
    List<Color> colors = [];
    Color orderStatusColor = GREEN_COLOR;
    String orderProcessingMessage = "Order under processing";
    String orderStatus = "";

    if (widget.orders.status == OrderStatuses.PLACED_BY_CUSTOMER) {
      setState(() {
        colors = [
          GREEN_COLOR,
          GREEN_COLOR.withOpacity(0.3),
          GREEN_COLOR.withOpacity(0.3),
          GREEN_COLOR.withOpacity(0.3)
        ];
        orderStatus = 'Placed by Customer';
      });
    }
    if (widget.orders.status == OrderStatuses.CANCELLED_BY_CUSTOMER) {
      setState(() {
        colors = [
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR
        ];
        orderStatusColor = PALE_RED_COLOR;
        orderStatus = 'Order cancelled by Customer';
      });
    }

    if (widget.orders.status == OrderStatuses.CANCELLED_BY_STORE) {
      setState(() {
        colors = [
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR
        ];
        orderStatusColor = PALE_RED_COLOR;
        orderStatus = 'Order cancelled by Store';
      });
    }

    if (widget.orders.status == OrderStatuses.RECEIVED_BY_STORE) {
      setState(() {
        colors = [
          GREEN_COLOR,
          GREEN_COLOR,
          GREEN_COLOR.withOpacity(0.3),
          GREEN_COLOR.withOpacity(0.3)
        ];
        orderStatus = 'Order received by store';
      });
    }

    if (widget.orders.status == OrderStatuses.PICKED_UP) {
      setState(() {
        colors = [
          GREEN_COLOR,
          GREEN_COLOR,
          GREEN_COLOR,
          GREEN_COLOR.withOpacity(0.3)
        ];
        orderStatus = 'Order picked up';
      });
    }
    if (widget.orders.status == OrderStatuses.DELIVERED_AND_PAID) {
      setState(() {
        colors = [
          GREEN_COLOR,
          GREEN_COLOR,
          GREEN_COLOR,
          GREEN_COLOR,
        ];
        orderStatus = 'Order delivered and paid';
        orderProcessingMessage = 'Order completed';
      });
    }
    if (cartItemLength == 2)
      cartItemNames =
          widget.cartItemInput[0].name + ', ' + widget.cartItemInput[1].name;
    else if (cartItemLength == 1)
      cartItemNames = widget.cartItemInput[0].name;
    else
      cartItemNames = widget.cartItemInput[0].name +
          ', ' +
          widget.cartItemInput[1].name +
          ' and ${cartItemLength - 2} more.';

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 15),
      child: InkWell(
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
                    'Order ID. ' + widget.orders.orderNo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs. ' + widget.orders.totalPrice.toString(),
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
                child: ScreenIndicatorRow(colors: colors),
              ),
              Container(padding: EdgeInsets.only(top: 6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    orderStatus,
                    style: TextStyle(
                      color: orderStatusColor,
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
                    widget.orders.paymentMode,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  ),
                  Text(
                    orderProcessingMessage,
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
