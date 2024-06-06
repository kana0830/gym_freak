import 'package:flutter/material.dart';

class AppColors {

  static const yellow = Color(0xFFFFF59D);
  static const darkYellow = Color(0xFF7b755e);
  static const calenderYellow = Color(0xFFFFF9C4);
  static const selectYellow = Color(0xFFffe071);

  /// テキストカラー
  static Color textColor(DateTime day) {
    const defaultTextColor = Colors.black87;
    switch (day.weekday) {
      case 6:
        return Colors.blue[600]!;
      case 7:
        return Colors.red;
      default:
        return defaultTextColor;
    }
  }
}
