import 'dart:convert';

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String storeName;
  final bool blocked;
  final String panCardPhotoUrls;
  final String shopPhotoUrl;
  final bool admin;
  final Map addressType;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.storeName,
    this.blocked,
    this.panCardPhotoUrls,
    this.shopPhotoUrl,
    this.admin,
    this.addressType,
  });

  factory User.fromJson(Map json) {
    return User(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        storeName: json['storeName'],
        blocked: json['blocked'],
        panCardPhotoUrls: json['panCardPhotoUrls'],
        shopPhotoUrl: json['shopPhotoUrl'],
        admin: json['admin'],
        addressType: jsonDecode(json['address']));
  }
}
