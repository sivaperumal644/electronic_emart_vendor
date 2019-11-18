import 'dart:convert';

import 'package:electronic_emart_vendor/modals/User.dart';

class Inventory {
  final String id;
  final String name;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final String category;
  final double inStock;
  final List imageUrls;
  final User vendor;
  final String averageRating;
  final int unAnswered;
  final double length;
  final double breadth;
  final double height;

  Inventory( {
    this.id,
    this.name,
    this.originalPrice,
    this.sellingPrice,
    this.description,
    this.category,
    this.inStock,
    this.imageUrls,
    this.vendor,
    this.averageRating,
    this.unAnswered,
    this.length, this.breadth, this.height,
  });

  factory Inventory.fromJson(Map json) {
    double length;
    double breadth;
    double height;
    if(json['length'] != null){
      length = double.parse(json['length'].toString());
    }
    if(json['breadth'] != null){
      breadth = double.parse(json['breadth'].toString());
    }
    if(json['height'] != null){
      height = double.parse(json['height'].toString());
    }

    return Inventory(
      id: json['id'],
      name: json['name'],
      originalPrice: double.parse(json['originalPrice'].toString()),
      sellingPrice: double.parse(json['sellingPrice'].toString()),
      description: json['description'],
      category: json['category'],
      inStock: json['inStock'].toDouble(),
      imageUrls: jsonDecode(json['imageUrl']),
      averageRating: json['averageRating'],
      unAnswered: json['unAnswered'],
      length: length,
      breadth: breadth,
      height: height,
    );
  }
}
