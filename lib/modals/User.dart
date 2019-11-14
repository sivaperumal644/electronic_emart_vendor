import 'dart:convert';

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String alternativePhone1;
  final String alternativePhone2;
  final String email;
  final String storeName;
  final bool blocked;
  final String panCardPhotoUrls;
  final String shopPhotoUrl;
  final bool admin;
  final Map addressType;
  final String paytmName;
  final String paytmNumber;
  final String amountToPay;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.alternativePhone1,
    this.alternativePhone2,
    this.email,
    this.storeName,
    this.blocked,
    this.panCardPhotoUrls,
    this.shopPhotoUrl,
    this.admin,
    this.addressType,
    this.amountToPay,
    this.paytmName,
    this.paytmNumber,
  });

  factory User.fromJson(Map json) {
    Map address;
    String amountToPay;
    String alternativePhone1;
    String alternativePhone2;
    if (json['address'] != null) {
      address = jsonDecode(json['address']);
    }
    if (json['amountToPay'] != null) {
      amountToPay = json['amountToPay'];
    }
    if (json['alternativePhone1'] != null) {
      alternativePhone1 = json['alternativePhone1'];
    }
    if (json['alternativePhone2'] != null) {
      alternativePhone2 = json['alternativePhone2'];
    }
    return User(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        alternativePhone1: alternativePhone1,
        alternativePhone2: alternativePhone2,
        email: json['email'],
        storeName: json['storeName'],
        blocked: json['blocked'],
        panCardPhotoUrls: json['panCardPhotoUrls'],
        shopPhotoUrl: json['shopPhotoUrl'],
        admin: json['admin'],
        addressType: address,
        amountToPay: amountToPay,
        paytmName: json['paytmName'],
        paytmNumber: json['paytmNumber']);
  }
}
