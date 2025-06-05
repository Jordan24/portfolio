import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeColorNotifier extends StateNotifier<Color> {
  ThemeColorNotifier() : super(const Color.fromARGB(255, 0, 32, 58));

  void setColor(Color color) {
    state = color;
  }
}

final themeColorProvider = StateNotifierProvider<ThemeColorNotifier, Color>((
  ref,
) {
  return ThemeColorNotifier();
});
