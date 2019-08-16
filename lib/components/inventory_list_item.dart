import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class InvetoryListItem extends StatelessWidget {
  final int currentPrice;
  final int discountPrice;
  final String stock;
  final int stockAvailable;
  final String inventoryItem;
  InvetoryListItem(
      {this.currentPrice,
      this.discountPrice,
      this.stock,
      this.stockAvailable,
      this.inventoryItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: PRIMARY_COLOR.withOpacity(0.08),
      ),
      child: Row(
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              FeatherIcons.edit,
              size: 24,
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }

  Widget stockRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          stock,
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
          '$stockAvailable in stock',
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
        Image.asset('assets/images/place_holder.png'),
        Container(margin: const EdgeInsets.only(left: 8.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                inventoryItem,
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
          'Rs. $currentPrice',
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: PRIMARY_COLOR.withOpacity(0.5),
            fontSize: 16,
          ),
        ),
        Container(margin: EdgeInsets.only(left: 8.0)),
        Text(
          'Rs. $discountPrice',
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
