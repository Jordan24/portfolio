import 'package:flutter/material.dart';

class KColorScheme {
  Color seedColor;

  KColorScheme() : seedColor = Colors.blueGrey;

  get kLightColorScheme {
    return ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: seedColor,
    );
  }

  get kDarkColorScheme {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: seedColor,
    );
  }
}
