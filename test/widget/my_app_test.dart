import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Finds a Button with text "Coming Soon"', (
    WidgetTester tester,
  ) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that a Button with the text "Push Me" is present.
    expect(find.widgetWithText(ElevatedButton, 'Coming Soon'), findsOneWidget);
  });
}