import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow lightShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  static const BoxShadow mediumShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static const BoxShadow heavyShadow = BoxShadow(
    color: Colors.black38,
    blurRadius: 20,
    offset: Offset(0, 8),
  );
}
