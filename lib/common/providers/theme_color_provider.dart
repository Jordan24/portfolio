import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeColorNotifier extends StateNotifier<Color> {
  Future<void> _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? colorValue = prefs.getInt('theme_color');
    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  Future<void> _saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_color', color.toARGB32());
  }

  ThemeColorNotifier() : super(const Color.fromARGB(255, 0, 32, 58)) {
    _loadThemeColor();
  }

  void setColor(Color color) {
    state = color;
    _saveThemeColor(color);
  }
}

final themeColorProvider = StateNotifierProvider<ThemeColorNotifier, Color>((
  ref,
) {
  return ThemeColorNotifier();
});
