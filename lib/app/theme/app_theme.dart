import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  );

  static ThemeData getAppTheme(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? darkTheme
        : lightTheme;
  }
}
