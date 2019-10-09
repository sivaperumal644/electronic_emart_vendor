import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class InventoryReview extends StatelessWidget {
  final double rating;
  final String review;
  final String reviewer;

  const InventoryReview({
    this.rating,
    this.review,
    this.reviewer,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GREY_COLOR, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {},
                starCount: 5,
                rating: rating,
                size: 20.0,
                color: PRIMARY_COLOR,
                borderColor: PRIMARY_COLOR,
                spacing: 0.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '$rating/5',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(height: 16),
          Align(
            alignment: Alignment.centerLeft,
                      child: Text(
              review,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Container(height: 16),
          Text(
            reviewer,
            style: TextStyle(fontSize: 12, color: PRIMARY_COLOR),
          )
        ],
      ),
    );
  }
}
