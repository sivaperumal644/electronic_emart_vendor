import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final Color color;

  SettingsOption({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color,),
          
        ],
      ),
    );
  }
}
