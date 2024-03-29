import 'package:carousel_pro/carousel_pro.dart';
import 'package:electronic_emart_vendor/components/inventory_question.dart';
import 'package:electronic_emart_vendor/components/inventory_review.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:electronic_emart_vendor/modals/QuestionAnswer.dart';
import 'package:electronic_emart_vendor/modals/ReviewModel.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../app_state.dart';

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
          getQAQueryComponent(),
          dividerLine(),
          getReviewsQueryComponent(),
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
                    fit: BoxFit.contain,
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
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  widget.inventory.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: PRIMARY_COLOR),
                ),
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

  Widget questionSection(
      List<QuestionAnswer> withoutAnswerQA, List<QuestionAnswer> withAnswerQA) {
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
          Container(height: 20),
          if (withoutAnswerQA.length == 0 && withAnswerQA.length == 0)
            Center(
              child: Text(
                'No Questions found',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: GREY_COLOR,
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                inventoryQuestionList(withoutAnswerQA),
                inventoryQuestionWithAnswerList(withAnswerQA)
              ],
            )
        ],
      ),
    );
  }

  Widget inventoryQuestionList(List<QuestionAnswer> listQA) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listQA.length,
      itemBuilder: (context, index) {
        return InventoryQuestion(
          questionId: listQA[index].id,
          question: listQA[index].questionText,
          isAnswered: false,
        );
      },
    );
  }

  Widget inventoryQuestionWithAnswerList(List<QuestionAnswer> listQA) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listQA.length,
      itemBuilder: (context, index) {
        return InventoryQuestion(
          questionId: listQA[index].id,
          question: listQA[index].questionText,
          answer: listQA[index].answerText,
          isAnswered: true,
        );
      },
    );
  }

  Widget reviewSection(avgRating, List<Review> reviews) {
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
                      rating: avgRating.toDouble(),
                      size: 20.0,
                      color: PRIMARY_COLOR,
                      borderColor: PRIMARY_COLOR,
                      spacing: 0.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        '$avgRating/5',
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
          if (reviews.length == 0)
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'No Review found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: GREY_COLOR,
                  ),
                ),
              ),
            )
          else
            inventoryReviewList(reviews)
        ],
      ),
    );
  }

  Widget inventoryReviewList(List<Review> reviews) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reviews.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InventoryReview(
            rating: reviews[index].rating,
            review: reviews[index].text,
            reviewer: reviews[index].customer.name,
            images: reviews[index].images);
      },
    );
  }

  Widget getReviewsQueryComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getReviewsQuery,
        variables: {'inventoryId': widget.inventory.id},
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getReviews'] != null &&
            result.data['getReviews']['averageRating'] != null &&
            result.data['getReviews']['reviews'] != null &&
            result.data['getReviews']['reviews'].length != 0) {
          final averageRating = double.parse(
              result.data['getReviews']['averageRating'].toString());
          List reviewList = result.data['getReviews']['reviews'];
          final reviews =
              reviewList.map((review) => Review.fromJson(review)).toList();
          return reviewSection(averageRating, reviews);
        }
        return reviewSection(0, []);
      },
    );
  }

  Widget getQAQueryComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getQAQuery,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
        variables: {'inventoryId': widget.inventory.id},
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getQA'] != null &&
            result.data['getQA'].length != 0) {
          List listQA = result.data['getQA'];
          final listOfQA =
              listQA.map((qa) => QuestionAnswer.fromJson(qa)).toList();
          final listOfQAWithoutAnswer = listOfQA
              .where((questionAnswer) => questionAnswer.answerText == null)
              .toList();
          final listOfQAWithAnswer = listOfQA
              .where((questionAnswer) => questionAnswer.answerText != null)
              .toList();
          return questionSection(listOfQAWithoutAnswer, listOfQAWithAnswer);
        }
        return questionSection([], []);
      },
    );
  }
}
