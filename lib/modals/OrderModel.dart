import 'dart:convert';

import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/User.dart';

class Order {
  final String id;
  final String orderNo;
  final Map address;
  final User customer;
  final List<CartItemInput> cartItems;
  final String status;
  final DateTime datePlaced;
  final DateTime updatedDate;
  final double totalPrice;
  final String paymentMode;
  final bool transactionSuccess;

  Order({
    this.id,
    this.orderNo,
    this.address,
    this.customer,
    this.cartItems,
    this.datePlaced,
    this.status,
    this.updatedDate,
    this.totalPrice,
    this.paymentMode,
    this.transactionSuccess,
  });

  factory Order.fromJson(Map json) {
    List cartItems = json['cartItems'];
    return Order(
        id: json['id'],
        orderNo: json['orderNo'],
        address: jsonDecode(json['address']),
        //customer: User.fromJson(json['customer']),
        cartItems: cartItems
            .map((i) => CartItemInput.fromJson(i['inventory']))
            .toList(),
        status: json['status'],
        datePlaced: DateTime.fromMicrosecondsSinceEpoch(
            int.parse(json['datePlaced']) * 1000),
        updatedDate: DateTime.fromMicrosecondsSinceEpoch(
            int.parse(json['updatedDate']) * 1000),
        totalPrice: json['totalPrice'].toDouble(),
        paymentMode: json['paymentMode'],
        transactionSuccess: json['transactionSuccess']);
  }
}
