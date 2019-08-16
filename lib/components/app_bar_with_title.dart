import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class AppBarWithTitle extends StatelessWidget {
  final String title;
  AppBarWithTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            color: PRIMARY_COLOR,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
