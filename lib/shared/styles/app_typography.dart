import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'YourCustomFont'; // Thay bằng font bạn dùng

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1C1E),
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: Color(0xFF1C1C1E),
  );

  // Light mode text theme
  static final TextTheme lightTextTheme = TextTheme(
    headlineLarge: headlineLarge,
    bodyLarge: bodyLarge,
  );

  // Dark mode text theme (chỉnh màu text)
  static final TextTheme darkTextTheme = TextTheme(
    headlineLarge: headlineLarge.copyWith(color: Colors.white),
    bodyLarge: bodyLarge.copyWith(color: Colors.white70),
  );
}
