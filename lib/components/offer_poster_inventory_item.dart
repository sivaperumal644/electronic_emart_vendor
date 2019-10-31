import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/InventoryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class OfferPosterInventoryItem extends StatefulWidget {
  final bool isAddOfferInventory;
  final Inventory inventoryItem;
  final Function onTap;
  final List<Inventory> selectedInventories;

  const OfferPosterInventoryItem({
    this.isAddOfferInventory = false,
    this.inventoryItem,
    this.onTap,
    this.selectedInventories,
  });
  @override
  _OfferPosterInventoryItemState createState() =>
      _OfferPosterInventoryItemState();
}

class _OfferPosterInventoryItemState extends State<OfferPosterInventoryItem> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected = widget.selectedInventories
            .where((inventory) => inventory.id == widget.inventoryItem.id)
            .length !=
        0;

    if (!widget.inventoryItem.name
        .toLowerCase()
        .contains(appState.getPosterSearchText.toLowerCase())) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.10),
        border: Border.all(
          color: isSelected ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.35),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: widget.isAddOfferInventory
                    ? Checkbox(
                        value: isSelected,
                        checkColor: WHITE_COLOR,
                        activeColor: PRIMARY_COLOR,
                        onChanged: (val) {
                          widget.onTap(widget.inventoryItem.id);
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 24,
                          color: PALE_RED_COLOR,
                        ),
                        onPressed: () {
                          widget.onTap(widget.inventoryItem.id);
                        },
                      ),
              ),
            ],
          ),
        ],
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          //'${widget.inventoryItem.category}',
          widget.inventoryItem.category,
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
        Image.network(
          widget.inventoryItem.imageUrls[0],
          fit: BoxFit.fill,
          height: 60,
          width: 60,
        ),
        Container(margin: const EdgeInsets.only(left: 8.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2.1,
              child: Text(
                widget.inventoryItem.name,
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
          widget.inventoryItem.originalPrice.toString(),
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: PRIMARY_COLOR.withOpacity(0.5),
            fontSize: 16,
          ),
        ),
        Container(margin: EdgeInsets.only(left: 8.0)),
        Text(
          widget.inventoryItem.sellingPrice.toString(),
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
