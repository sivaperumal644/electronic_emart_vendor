import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;

  CustomTextField({
    this.labelText,
    this.onChanged,
    this.hintText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: PRIMARY_COLOR.withOpacity(0.03),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: PRIMARY_COLOR.withOpacity(0.35),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
