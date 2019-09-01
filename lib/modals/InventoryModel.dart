import 'package:electronic_emart_vendor/modals/User.dart';

class Inventory {
  final String id;
  final String name;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final String category;
  final double inStock;
  final String imageUrl;
  final User vendor;

  Inventory({
    this.id,
    this.name,
    this.originalPrice,
    this.sellingPrice,
    this.description,
    this.category,
    this.inStock,
    this.imageUrl,
    this.vendor,
  });

  factory Inventory.fromJson(Map json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      originalPrice: json['originalPrice'].toDouble(),
      sellingPrice: json['sellingPrice'].toDouble(),
      description: json['description'],
      category: json['category'],
      inStock: json['inStock'].toDouble(),
      imageUrl: json['imageUrl'],
      vendor: User.fromJson(json['vendor']),
    );
  }
}
