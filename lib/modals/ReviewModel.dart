import 'dart:convert';

import 'User.dart';

class Review {
  final String id;
  final String date;
  final double rating;
  final String text;
  final User customer;
  final List images;

  Review({
    this.id,
    this.date,
    this.rating,
    this.text,
    this.customer,
    this.images,
  });

  factory Review.fromJson(Map json) {
    List images;
    if (json['images'] != null) {
      images = jsonDecode(json['images']);
    }
    return Review(
      id: json['id'],
      // date: json['date'],
      rating: json['rating'].toDouble(),
      text: json['text'],
      customer: User.fromJson(json['customer']),
      images: images,
    );
  }
}
