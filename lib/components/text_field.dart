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
  final int maxLength;
  final String counterText;

  CustomTextField({
    this.onChanged,
    this.hintText,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.obscureText,
    this.maxLength,
    this.counterText,
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
        maxLength: maxLength,
        obscureText: obscureText,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: maxLength == null && counterText == null
              ? null
              : EdgeInsets.only(top: 12, bottom: -2),
          border: InputBorder.none,
          hintText: hintText,
          counterText: counterText,
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
