import 'package:carousel_pro/carousel_pro.dart';
import 'package:electronic_emart_vendor/components/inventory_question.dart';
import 'package:electronic_emart_vendor/components/inventory_review.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/screens/inventory_detail_screen/answer_screen.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class InventortDetailScreen extends StatefulWidget {
  final Inventory inventory;

  const InventortDetailScreen({this.inventory});
  @override
  _InventortDetailScreenState createState() => _InventortDetailScreenState();
}

class _InventortDetailScreenState extends State<InventortDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          appBar(),
          imagePageView(),
          itemDescription(),
          dividerLine(),
          questionSection(),
          dividerLine(),
          reviewSection(),
        ],
      ),
    );
  }

  Container dividerLine() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 24),
      height: 2,
      color: PRIMARY_COLOR.withOpacity(0.2),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddInventoryScreen(
                    inventory: widget.inventory,
                    isNewInventory: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  Widget imagePageView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Hero(
        tag: widget.inventory.id,
        child: SizedBox(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            images: widget.inventory.imageUrls
                .map(
                  (f) => Image.network(
                    f,
                    fit: BoxFit.fitWidth,
                  ),
                )
                .toList(),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: PRIMARY_COLOR,
            indicatorBgPadding: 5.0,
            borderRadius: true,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
          ),
        ),
      ),
    );
  }

  Widget itemDescription() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.inventory.name,
                style: TextStyle(fontSize: 30, color: PRIMARY_COLOR),
              ),
            ],
          ),
          Container(height: 16),
          Text(
            'Item Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 12),
          Text(
            widget.inventory.description,
            style: TextStyle(
              color: GREY_COLOR,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget questionSection() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Customer Questions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: InventoryQuestion(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerPost(
                      question:
                          'What is the waterproof grading of this product, can I use tempered glass on it?',
                    ),
                  ),
                );
              },
              question:
                  'What is the waterproof grading of this product, can I use tempered glass on it?',
              answer: 'ADD AN ANSWER',
              isAnswered: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: InventoryQuestion(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerPost(
                      question:
                          'What is the waterproof grading of this product, can I use tempered glass on it?',
                    ),
                  ),
                );
              },
              question:
                  'What is the waterproof grading of this product, can I use tempered glass on it?',
              answer: 'It is IP68. And yes, you can use tempered glass.',
              isAnswered: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewSection() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Item Reviews',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Avg. Rating',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {},
                      starCount: 5,
                      rating: 4.5,
                      size: 20.0,
                      color: PRIMARY_COLOR,
                      borderColor: PRIMARY_COLOR,
                      spacing: 0.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        '4.5/5',
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: InventoryReview(
              rating: '4.5',
              review:
                  'Works very well, and looks even better. It’s been a few days since I purchased this and it works very well',
              reviewer: 'Siva Perumal K',
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: InventoryReview(
              rating: '4.5',
              review:
                  'Works very well, and looks even better. It’s been a few days since I purchased this and it works very well',
              reviewer: 'Siva Perumal K',
            ),
          ),
        ],
      ),
    );
  }
}
