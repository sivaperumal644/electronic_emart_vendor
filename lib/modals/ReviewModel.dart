import 'User.dart';

class Review {
  final String id;
  final String date;
  final double rating;
  final String text;
  final User customer;

  Review({
    this.id,
    this.date,
    this.rating,
    this.text,
    this.customer,
  });

  factory Review.fromJson(Map json) {
    print(json['customer']);
    return Review(
      id: json['id'],
      // date: json['date'],
      rating: json['rating'].toDouble(),
      text: json['text'],
       customer: User.fromJson(json['customer']),
    );
  }
}
