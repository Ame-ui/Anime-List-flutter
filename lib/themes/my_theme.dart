import 'package:flutter/material.dart';

class MyTheme {
  static const Color bgColor = Color(0xfff4f5f8);
  static const Color primaryColor = Color(0xff1e98c1);
  static const Color shadowCOlor = Color(0xff808080);

  static ThemeData lightThemeData = ThemeData(
      primarySwatch: Colors.blueGrey,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        brightness: Brightness.light,
        background: bgColor,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
        ),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: primaryColor, shadowColor: Colors.grey));

  static ThemeData darkThemeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
