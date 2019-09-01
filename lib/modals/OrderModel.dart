import 'package:electronic_emart_vendor/modals/CartItemInputModel.dart';
import 'package:electronic_emart_vendor/modals/User.dart';

class Order{
  final String id;
  final String orderNo;
  final String address;
  final User vendor;
  final User customer;
  final CartItemInput cartItems;
  final String status;
  final String datePlaced;
  final String updatedDate;
  final double totalPrice;
  final String paymentMode;

  Order({this.id, this.orderNo, this.address, this.vendor, this.customer, this.cartItems, this.datePlaced, this.status, this.updatedDate, this.totalPrice, this.paymentMode});

  factory Order.fromJson(Map json){
    return Order(
      id: json['id'],
      orderNo: json['orderNo'],
      address: json['address'],
      vendor: User.fromJson(json['vendor']),
      customer: User.fromJson(json['customer']),
      cartItems: CartItemInput.fromJson(json['cartItems']),
      status:json['status'],
      datePlaced: json['datePlaced'],
      updatedDate: json['updatedDate'],
      totalPrice: json['totalPrice'],
      paymentMode: json['paymentMode'],
    );
  }

  
}