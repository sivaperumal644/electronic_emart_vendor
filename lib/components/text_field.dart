import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final controller;
  final String errorText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;

  CustomTextField({
    this.onChanged,
    this.hintText,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: PRIMARY_COLOR.withOpacity(0.1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
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
