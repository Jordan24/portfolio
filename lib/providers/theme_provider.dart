import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the StateNotifier that will manage the Color state
class ThemeColorNotifier extends StateNotifier<Color> {
  ThemeColorNotifier() : super(const Color.fromARGB(255, 0, 32, 58));

  // Method to update the color
  void setColor(Color color) {
    state = color;
  }
}

// Define the StateNotifierProvider
final themeColorProvider = StateNotifierProvider<ThemeColorNotifier, Color>((ref) {
  return ThemeColorNotifier();
});
