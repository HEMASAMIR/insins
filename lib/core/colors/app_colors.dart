import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color mainGray = Color(0xFF555555);
  static const Color topBarGray = Color(0xFF1A1A1A);
  static const Color gold = Color(0xFF93908B);
  static const Color maroon = Color(0xFF632424);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightBg = Color(0xFFF9F9F9);
  static const Color gradientDarkStart = Color.fromRGBO(44, 44, 44, 0.9);

  static const Color gradientDarkMiddle = Color.fromRGBO(26, 26, 26, 0.6);

  static const Color gradientDarkEnd = Color.fromRGBO(0, 0, 0, 0.85);
  static const Color darkGrey = Color(0xFF333333); // الرمادي الغامق للنصوص
  static const Color lightGrey = Color(0xFF707070); // نصوص الوصف
  static const Color bgGrey = Color(0xFFF9F9F9);
  // Gold Transparent
  static const Color goldTransparent = Color.fromRGBO(197, 160, 89, 0.2);
  final Color goldColor = const Color(0xFF93908B);
  static Color darkBg = const Color(0xFF111111);

  // Predefined Gradient
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientDarkStart, gradientDarkMiddle, gradientDarkEnd],
  );
}
