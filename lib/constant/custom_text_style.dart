import 'package:flutter/material.dart';

class CustomTextStyle {
  const CustomTextStyle();

  static TextStyle getAppBarTitleStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
  static TextStyle getCompTitleStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );
  static TextStyle getsubTitleStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );
  static TextStyle getTitleStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
  static TextStyle getInterestTagStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 8,
      );

  static TextStyle getTextFieldStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle getDescStyle(Color color) => TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      );
}
