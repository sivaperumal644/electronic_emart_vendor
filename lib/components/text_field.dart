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

  CustomTextField({
    this.onChanged,
    this.hintText,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.obscureText,
    this.maxLength,
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
          contentPadding: maxLength == null ? null : EdgeInsets.only(top: 12, bottom: 4),
          border: InputBorder.none,
          hintText: hintText,
          counter: maxLength == null ? null : Container(height: 0, width: 0),
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
