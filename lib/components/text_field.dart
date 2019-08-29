import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final controller;
  final String errorText;

  CustomTextField({
    this.labelText,
    this.onChanged,
    this.hintText,
    this.controller,
    this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: PRIMARY_COLOR.withOpacity(0.1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
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
