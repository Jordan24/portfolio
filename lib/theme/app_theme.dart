import 'package:flutter/material.dart';

class AppTheme {
  AppTheme({required this.currentThemeColor});

  final Color currentThemeColor;

  static ThemeData lightMode = ThemeData().copyWith(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      foregroundColor: ThemeData.dark().colorScheme.onSurface,
    ),
  );

  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      foregroundColor: ThemeData.dark().colorScheme.onPrimary,
    ),
  );
}
