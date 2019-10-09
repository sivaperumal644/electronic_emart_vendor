import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class InvetoryListItem extends StatelessWidget {
  final Inventory inventoryItem;
  final Function onTap;
  InvetoryListItem({this.inventoryItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (!inventoryItem.name
        .toLowerCase()
        .contains(appState.getSearchText.toLowerCase())) {
      return Container();
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: PRIMARY_COLOR.withOpacity(0.06),
            border: Border.all(color: PRIMARY_COLOR.withOpacity(0.6))),
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
              rating: double.parse(inventoryItem.averageRating),
              size: 20.0,
              color: PRIMARY_COLOR,
              borderColor: PRIMARY_COLOR,
              spacing: 0.0,
            ),
            Container(height: 4),
            Text(
              '3 unanswered questions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget stockRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${inventoryItem.category}',
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
          '${inventoryItem.inStock} in stock',
          style: TextStyle(
            color: BLACK_COLOR,
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
          tag: inventoryItem.id,
          child: Image.network(
            inventoryItem.imageUrls[0],
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
                '${inventoryItem.name}',
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
        Text(
          'Rs. ${inventoryItem.originalPrice}',
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: PRIMARY_COLOR.withOpacity(0.5),
            fontSize: 16,
          ),
        ),
        Container(margin: EdgeInsets.only(left: 8.0)),
        Text(
          'Rs. ${inventoryItem.sellingPrice}',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
