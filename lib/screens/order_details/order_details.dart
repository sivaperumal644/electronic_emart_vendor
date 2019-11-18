import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/order_details.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/secondary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/OrderModel.dart';
import 'package:electronic_emart_vendor/screens/order_details/change_order_status_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order orders;
  final List<CartItemInput> cartItemInput;

  const OrderDetailsScreen({this.orders, this.cartItemInput});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isChangeButtonClicked = false;
  bool isRejectButtonClicked = false;
  bool isGenerateButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FeatherIcons.arrowLeft,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24, 16, 24, 42),
            child: OrderDetails(
              order: widget.orders,
              cartItemInput: widget.cartItemInput,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24),
            child: Text(
              'ORDER ACTIONS',
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if ((widget.orders.cartItems[0].itemStatus ==
                      OrderStatuses.PLACED_BY_CUSTOMER &&
                  (widget.orders.transactionSuccess == true ||
                      widget.orders.paymentMode == 'Cash On Delivery')) ||
              widget.orders.cartItems[0].itemStatus ==
                  OrderStatuses.RECEIVED_BY_STORE)
            isChangeButtonClicked
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CupertinoActivityIndicator(),
                  )
                : changeOrderStatusMutationComponent(),
          isGenerateButtonClicked
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CupertinoActivityIndicator(),
                )
              : Container(
                  margin:
                      EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                  child: SecondaryButton(
                    buttonText: 'Generate Bill',
                    onPressed: () {
                      generateBill();
                    },
                  ),
                ),
          if ((widget.orders.cartItems[0].itemStatus ==
                      OrderStatuses.PLACED_BY_CUSTOMER &&
                  (widget.orders.transactionSuccess == true ||
                      widget.orders.paymentMode == 'Cash On Delivery')) ||
              widget.orders.cartItems[0].itemStatus ==
                  OrderStatuses.RECEIVED_BY_STORE)
            isRejectButtonClicked
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CupertinoActivityIndicator(),
                  )
                : rejectOrderMutationComponent()
        ],
      ),
    );
  }

  Widget rejectButton(RunMutation runMutation) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: TertiaryButton(
        text: widget.orders.cartItems[0].itemStatus ==
                OrderStatuses.PLACED_BY_CUSTOMER
            ? 'Reject Order'
            : 'Cancel Order',
        onPressed: () {
          setState(() {
            isRejectButtonClicked = true;
          });
          runMutation({
            'status': OrderStatuses.CANCELLED_BY_STORE,
            'orderId': widget.orders.id
          });
        },
      ),
    );
  }

  Widget changeStatusButton(RunMutation runMutation) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: PrimaryButtonWidget(
        buttonText: widget.orders.cartItems[0].itemStatus ==
                OrderStatuses.PLACED_BY_CUSTOMER
            ? 'Accept Order'
            : 'Order Picked up',
        onPressed: () {
          setState(() {
            isChangeButtonClicked = true;
          });
          runMutation({
            'status': widget.orders.cartItems[0].itemStatus ==
                    OrderStatuses.PLACED_BY_CUSTOMER
                ? OrderStatuses.RECEIVED_BY_STORE
                : OrderStatuses.PICKED_UP,
            'orderId': widget.orders.id
          });
        },
      ),
    );
  }

  Widget changeOrderStatusMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: changeOrderStatusMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        print(result.errors);
        print(result.data);
        return changeStatusButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData['changeOrderStatus']['error'] == null) {
        Navigator.pop(context);
        } else {
          setState(() {
            isChangeButtonClicked = false;
          });
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: 'Could not change status',
                contentMessage:
                    'Could not change the status, Check your internet connection and try again.',
                isRegister: false,
              );
            },
          );
        }
      },
    );
  }

  Widget rejectOrderMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: changeOrderStatusMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return rejectButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData['changeOrderStatus']['error'] == null) {
          Navigator.pop(context);
        } else {
          setState(() {
            isChangeButtonClicked = false;
          });
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: 'Could not reject order',
                contentMessage:
                    'Could not reject the order, Check your internet connection and try again.',
                isRegister: false,
              );
            },
          );
        }
      },
    );
  }

  void generateBill() async {
    final appState = Provider.of<AppState>(context);
    String orderId = widget.orders.id;
    String vendorId = appState.getVendorId;
    String url =
        'http://cezhop.herokuapp.com/generateBill?orderId=$orderId&vendorId=$vendorId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
