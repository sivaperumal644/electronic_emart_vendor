import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class InvetoryListItem extends StatefulWidget {
  final Inventory inventoryItem;
  final Function onTap;
  InvetoryListItem({this.inventoryItem, this.onTap});

  @override
  _InvetoryListItemState createState() => _InvetoryListItemState();
}

class _InvetoryListItemState extends State<InvetoryListItem> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    bool isEmpty = false;
    if (!widget.inventoryItem.name
        .toLowerCase()
        .contains(appState.getSearchText.toLowerCase())) {
      return Container();
    }
    if (widget.inventoryItem.inStock < 1) {
      setState(() {
        isEmpty = true;
      });
    } else {
      setState(() {
        isEmpty = false;
      });
    }

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isEmpty
                ? PALE_RED_COLOR.withOpacity(0.1)
                : PRIMARY_COLOR.withOpacity(0.06),
            border: Border.all(
                color:
                    isEmpty ? PALE_RED_COLOR : PRIMARY_COLOR.withOpacity(0.6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    inventoryListRow(context),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: stockRow(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    FeatherIcons.edit,
                    size: 24,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 1,
              color: PRIMARY_COLOR.withOpacity(0.20),
            ),
            SmoothStarRating(
              allowHalfRating: false,
              onRatingChanged: (v) {},
              starCount: 5,
              rating: double.parse(widget.inventoryItem.averageRating),
              size: 20.0,
              color: PRIMARY_COLOR,
              borderColor: PRIMARY_COLOR,
              spacing: 0.0,
            ),
            Container(height: 4),
            Text(
              '${widget.inventoryItem.unAnswered.toString()} unanswered questions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget stockRow() {
    int itemInStock;
    if (widget.inventoryItem.inStock < 1) {
      setState(() {
        itemInStock = 0;
      });
    } else {
      setState(() {
        itemInStock = widget.inventoryItem.inStock.toInt();
      });
    }
    bool isEmpty = itemInStock < 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${widget.inventoryItem.category}',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 3,
          width: 3,
          margin: EdgeInsets.only(left: 3, right: 3, top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: BLACK_COLOR,
          ),
        ),
        Text(
          '$itemInStock in stock',
          style: TextStyle(
            color: isEmpty ? PALE_RED_COLOR : BLACK_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget inventoryListRow(context) {
    return Row(
      children: <Widget>[
        Hero(
          tag: widget.inventoryItem.id,
          child: Image.network(
            widget.inventoryItem.imageUrls[0],
            fit: BoxFit.contain,
            height: 80,
            width: 80,
          ),
        ),
        Container(margin: const EdgeInsets.only(left: 8.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2.1,
              child: Text(
                '${widget.inventoryItem.name}',
                style: TextStyle(
                  color: BLACK_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            priceTextRow(),
          ],
        ),
      ],
    );
  }

  Widget priceTextRow() {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: PRIMARY_COLOR.withOpacity(0.5),
              fontSize: 16,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '₹ ',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: PRIMARY_COLOR.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '${widget.inventoryItem.originalPrice}',
              )
            ],
          ),
        ),
        Container(margin: EdgeInsets.only(left: 8.0)),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '₹ ',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: PRIMARY_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '${widget.inventoryItem.sellingPrice}',
              )
            ],
          ),
        ),
      ],
    );
  }
}
