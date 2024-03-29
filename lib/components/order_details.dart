import 'package:electronic_emart_vendor/components/screen_indicator_row.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final List<CartItemInput> cartItemInput;
  final Order order;
  OrderDetails({this.cartItemInput, this.order});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    String statusTitle = StringResolver.getTextForOrderStatus(
        status: widget.order.cartItems[0].itemStatus);
    String statusMessage = StringResolver.getMessageForOrderStatus(
        status: widget.order.cartItems[0].itemStatus);
    List<Color> colors = [];
    Color statusMessageColor = PRIMARY_COLOR;

    if (widget.cartItemInput[0].itemStatus ==
        OrderStatuses.PLACED_BY_CUSTOMER) {
      setState(() {
        colors = [
          PRIMARY_COLOR,
          PRIMARY_COLOR.withOpacity(0.3),
          PRIMARY_COLOR.withOpacity(0.3),
          PRIMARY_COLOR.withOpacity(0.3)
        ];
      });
    }
    if (widget.cartItemInput[0].itemStatus ==
            OrderStatuses.CANCELLED_BY_CUSTOMER ||
        widget.cartItemInput[0].itemStatus ==
            OrderStatuses.CANCELLED_BY_STORE ||
        widget.cartItemInput[0].itemStatus ==
            OrderStatuses.TRANSACTION_FAILED) {
      setState(() {
        colors = [
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR,
          PALE_RED_COLOR
        ];
        statusMessageColor = PALE_RED_COLOR;
      });
    }
    if (widget.cartItemInput[0].itemStatus == OrderStatuses.RECEIVED_BY_STORE) {
      setState(() {
        colors = [
          PRIMARY_COLOR,
          PRIMARY_COLOR,
          PRIMARY_COLOR.withOpacity(0.3),
          PRIMARY_COLOR.withOpacity(0.3)
        ];
      });
    }

    if (widget.cartItemInput[0].itemStatus == OrderStatuses.PICKED_UP) {
      setState(() {
        colors = [
          PRIMARY_COLOR,
          PRIMARY_COLOR,
          PRIMARY_COLOR,
          PRIMARY_COLOR.withOpacity(0.3)
        ];
      });
    }
    if (widget.cartItemInput[0].itemStatus ==
        OrderStatuses.DELIVERED_AND_PAID) {
      setState(() {
        colors = [PRIMARY_COLOR, PRIMARY_COLOR, PRIMARY_COLOR, PRIMARY_COLOR];
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        itemHeaderText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              widget.order.paymentMode,
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
                  color: statusMessageColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ScreenIndicatorRow(colors: colors),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Text(
            statusTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: statusMessageColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            statusMessage,
            style: TextStyle(
              fontSize: 14,
              color: BLACK_COLOR,
            ),
          ),
        ),
        widget.order.cancelledReason != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'CANCELLED REASON',
                      style: TextStyle(
                        color: PALE_RED_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.order.cancelledReason,
                      style: TextStyle(
                        fontSize: 14,
                        color: BLACK_COLOR,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
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
            widget.order.address['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          widget.order.address['addressLine'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          widget.order.address['landmark'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          widget.order.address['city'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: BLACK_COLOR,
            fontSize: 14,
          ),
        ),
        Text(
          widget.order.address['phoneNumber'],
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
      itemCount: widget.cartItemInput.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: orderItemsRow(widget.cartItemInput[index]),
        );
      },
    );
  }

  Widget orderItemsRow(CartItemInput cartItemInputDetails) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GREY_COLOR.withOpacity(0.15)),
      child: Row(
        children: <Widget>[
          Image.network(cartItemInputDetails.inventory.imageUrls[0],
              fit: BoxFit.cover, width: 55, height: 55),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Text(
                    cartItemInputDetails.inventory.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BLACK_COLOR,
                      fontSize: 14,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR,
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
                        text: cartItemInputDetails.inventory.sellingPrice
                            .toString(),
                      )
                    ],
                  ),
                ),
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
          'Order ID. BS' + widget.order.orderNo,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '₹ ',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: PRIMARY_COLOR,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: widget.order.totalPrice.toString().toString(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
