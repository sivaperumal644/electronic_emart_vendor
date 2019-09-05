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
  final String datePlaced;
  final String updatedDate;
  final double totalPrice;
  final String paymentMode;

  Order(
      {this.id,
      this.orderNo,
      this.address,
      this.customer,
      this.cartItems,
      this.datePlaced,
      this.status,
      this.updatedDate,
      this.totalPrice,
      this.paymentMode,});

  factory Order.fromJson(Map json) {
    List cartItems = json['cartItems'];
    return Order(
      id: json['id'],
      orderNo: json['orderNo'],
      address: jsonDecode(json['address']),
      customer: User.fromJson(json['customer']),
      cartItems: cartItems.map((i) => CartItemInput.fromJson(i)).toList(),
      status: json['status'],
      datePlaced: json['datePlaced'],
      updatedDate: json['updatedDate'],
      totalPrice: json['totalPrice'].toDouble(),
      paymentMode: json['paymentMode'],
    );
  }
}
