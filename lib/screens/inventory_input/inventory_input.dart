import 'package:electronic_emart_vendor/components/chips_component.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class AddInventoryScreen extends StatefulWidget {
  final bool isNewInventory;

  AddInventoryScreen({this.isNewInventory});

  @override
  _AddInventoryScreenState createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  String selectedChips = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          appBar(),
          headerText('Name and Category'),
          Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0),
            child: CustomTextField(
              hintText: 'Product Name',
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
            child: ChipsComponent(
              itemList: [
                "Mobile Phones",
                "Headphones",
                "Laptops",
                "Accessories"
              ],
              selectedChips: selectedChips,
              onChanged: (value) {
                setState(() {
                  selectedChips = value;
                });
              },
            ),
          ),
          headerText('Pricing'),
          priceFields(),
          Container(
            padding: EdgeInsets.only(top: 20, left: 24, right: 24),
            child: HeaderAndSubHeader(
              headerText: 'Item Description',
              subHeaderText:
                  'You must provide a proper description of the item details',
            ),
          ),
          Container(
            height: 130,
            margin: EdgeInsets.all(24),
            child: CustomTextField(
              hintText: 'Description',
            ),
          ),
          headerText('Quantity in Stock'),
          Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 20.0),
            child: CustomTextField(hintText: 'Items in Stock'),
          ),
          widget.isNewInventory
              ? Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: PrimaryButtonWidget(
                    buttonText: 'Save Changes',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TertiaryButton(
                        text: 'Delete Item',
                        onPressed: () {},
                      ),
                      PrimaryButtonWidget(
                        buttonText: 'Save Changes',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget priceFields() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: CustomTextField(
                  hintText: 'Original Price (MRP)',
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 2,
                child: CustomTextField(
                  hintText: 'Selling Price (for sale)',
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Rs. 12,000',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                  color: PALE_RED_COLOR,
                ),
              ),
              Text(
                'Rs. 13,000',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                  color: PRIMARY_COLOR,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  'Enter the prices to see how they appear',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: GREY_COLOR,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget headerText(text) {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.only(top: 42.0, left: 22.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
          ),
          Container(width: 20),
          Text(
            widget.isNewInventory ? 'Add new item' : 'Edit item',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }
}
