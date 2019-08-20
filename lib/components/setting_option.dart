import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String title;

  SettingsOption({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: BLACK_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}