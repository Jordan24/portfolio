// import 'package:flutter_test/flutter_test.dart';
// import 'package:portfolio/main.dart'; // Adjust if your package name is different
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

void main() {
  // group('SharedPreferencesWithCache Tests', () {
  //   const Color testColor1 = Colors.red;
  //   const Color testColor2 = Colors.green;
  //   const Color defaultColor = Color.fromARGB(255, 0, 32, 58);

  //   setUp(() async {
  //     // Set up mock initial values for SharedPreferences
  //     SharedPreferences.setMockInitialValues({});
  //     // Reset the cache before each test
  //     SharedPreferencesWithCache.resetCache();
  //   });

  //   tearDown(() {
  //     // Reset the cache after each test
  //     SharedPreferencesWithCache.resetCache();
  //   });

  //   test('setThemeColor and getThemeColor work correctly', () async {
  //     // Set a theme color
  //     await SharedPreferencesWithCache.setThemeColor(testColor1);

  //     // Get the theme color
  //     final retrievedColor = await SharedPreferencesWithCache.getThemeColor();

  //     // Assert that the retrieved color is the same as the set color
  //     expect(retrievedColor, testColor1);
  //   });

  //   test('getThemeColor returns default color when no color is set', () async {
  //     // Get the theme color without setting any
  //     final retrievedColor = await SharedPreferencesWithCache.getThemeColor();

  //     // Assert that the retrieved color is the default color
  //     expect(retrievedColor, defaultColor);
  //   });

  //   test('getThemeColor returns cached color after initial fetch', () async {
  //     // 1. Set an initial color directly in SharedPreferences mock
  //     SharedPreferences.setMockInitialValues({'themeColor': testColor1.value});
  //     SharedPreferencesWithCache.resetCache(); // Ensure cache is clear

  //     // 2. Call getThemeColor() to populate the cache
  //     Color colorFromPrefs = await SharedPreferencesWithCache.getThemeColor();
  //     expect(colorFromPrefs, testColor1); // Should be from mock prefs

  //     // 3. Change the underlying mock values *without* calling setThemeColor
  //     SharedPreferences.setMockInitialValues({'themeColor': testColor2.value});
  //     // Note: We do NOT reset SharedPreferencesWithCache._prefsInstance here
  //     // to simulate that the SharedPreferences instance itself hasn't changed,
  //     // only its underlying data, which getThemeColor shouldn't pick up if cached.

  //     // 4. Call getThemeColor() again and verify it returns the *cached* color
  //     Color cachedColor = await SharedPreferencesWithCache.getThemeColor();
  //     expect(cachedColor, testColor1); // Should still be the initially cached color

  //     // 5. Then call setThemeColor() with a new color
  //     await SharedPreferencesWithCache.setThemeColor(testColor2);

  //     // 6. Call getThemeColor() and verify it returns the *newly set* color (cache updated)
  //     Color newSetColor = await SharedPreferencesWithCache.getThemeColor();
  //     expect(newSetColor, testColor2);
  //   });

  //    test('setThemeColor updates cache and SharedPreferences', () async {
  //     // 1. Set an initial color and populate cache
  //     await SharedPreferencesWithCache.setThemeColor(testColor1);
  //     Color color = await SharedPreferencesWithCache.getThemeColor();
  //     expect(color, testColor1);

  //     // 2. Set a new color
  //     await SharedPreferencesWithCache.setThemeColor(testColor2);

  //     // 3. Verify getThemeColor returns the new color (from cache)
  //     Color newCachedColor = await SharedPreferencesWithCache.getThemeColor();
  //     expect(newCachedColor, testColor2);

  //     // 4. Clear cache and verify getThemeColor still returns the new color (from SharedPreferences)
  //     SharedPreferencesWithCache.resetCache();
  //     // Re-initialize the SharedPreferences instance for SharedPreferencesWithCache
  //     // as resetCache also nullifies _prefsInstance.
  //     // The actual SharedPreferences.getInstance() in the app would get the values
  //     // that were last written.
  //     // For testing, we need to ensure our mock has the latest value.
  //     // SharedPreferences.setMockInitialValues is global for the test suite,
  //     // so the value set by setThemeColor (testColor2) should be there.
  //     // We simulate a new app load by resetting the cache.
  //     Color newColorFromPrefs = await SharedPreferencesWithCache.getThemeColor();
  //     expect(newColorFromPrefs, testColor2);
  //   });


  //   test('getThemeColor loads from SharedPreferences if cache is empty', () async {
  //     // 1. Set a color directly in SharedPreferences mock
  //     SharedPreferences.setMockInitialValues({'themeColor': testColor1.value});
  //     SharedPreferencesWithCache.resetCache(); // Ensure cache is empty

  //     // 2. Call getThemeColor
  //     final retrievedColor = await SharedPreferencesWithCache.getThemeColor();

  //     // 3. Assert that the color is loaded from SharedPreferences
  //     expect(retrievedColor, testColor1);
  //   });

  //   test('getThemeColor returns default if SharedPreferences value is invalid', () async {
  //     // 1. Set an invalid value in SharedPreferences mock
  //     SharedPreferences.setMockInitialValues({'themeColor': 'invalid_color_value'});
  //      SharedPreferencesWithCache.resetCache();

  //     // 2. Call getThemeColor
  //     final retrievedColor = await SharedPreferencesWithCache.getThemeColor();

  //     // 3. Assert that the retrieved color is the default color
  //     // This test depends on how getInt handles non-integer values.
  //     // SharedPreferences.getInt returns null if the value is not an int.
  //     expect(retrievedColor, defaultColor);
  //   });
  // });
}
