import 'package:electronic_emart_vendor/modals/User.dart';

class CartItemInput {
  final String id;
  final String name;
  final String category;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final double inStock;
  final String imageUrl;
  final User vendor;

  CartItemInput({
    this.id,
    this.name,
    this.category,
    this.originalPrice,
    this.sellingPrice,
    this.description,
    this.inStock,
    this.imageUrl,
    this.vendor,
  });

  factory CartItemInput.fromJson(Map json) {
    return CartItemInput(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      originalPrice: json['originalPrice'].toDouble(),
      sellingPrice: json['sellingPrice'].toDouble(),
      description: json['description'],
      inStock: json['inStock'].toDouble(),
      imageUrl: json['imageUrl'],
      vendor: User.fromJson(json['vendor']),
    );
  }
}
