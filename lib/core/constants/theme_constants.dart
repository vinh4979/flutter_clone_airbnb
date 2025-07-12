import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);
