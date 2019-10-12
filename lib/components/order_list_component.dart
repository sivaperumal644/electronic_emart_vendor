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
  final bool isActiveOrders;

  OrderListWidget({
    this.orders,
    this.cartItemInput,
    this.isActiveOrders = false,
  });

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
    Color orderTransactionStatusColor = GREEN_COLOR;
    String orderProcessingMessage = "Waiting store confirmation";
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
        orderProcessingMessage = 'Waiting store confirmation';
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
        orderProcessingMessage = 'Order Cancelled';
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
        orderProcessingMessage = 'Order Cancelled';
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
        orderProcessingMessage = 'Order under processing';
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
        orderProcessingMessage = 'Order under processing';
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
    if (widget.orders.transactionSuccess == false &&
        widget.orders.paymentMode != 'Cash On Delivery') {
      setState(() {
        orderProcessingMessage = 'Order Cancelled';
      });
    }
    if (widget.orders.transactionSuccess)
      orderTransactionStatusColor = GREEN_COLOR;
    else
      orderTransactionStatusColor = PALE_RED_COLOR;
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
              color: widget.isActiveOrders
                  ? PRIMARY_COLOR.withOpacity(0.05)
                  : PRIMARY_COLOR.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: widget.isActiveOrders
                  ? Border.all(color: PRIMARY_COLOR, width: 1)
                  : null),
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    widget.orders.paymentMode != "Cash On Delivery"
                        ? Text(
                            widget.orders.transactionSuccess
                                ? 'Transaction Success'
                                : 'Transaction failed',
                            style: TextStyle(
                              color: orderTransactionStatusColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Text(
                        orderStatus,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: orderStatusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
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
