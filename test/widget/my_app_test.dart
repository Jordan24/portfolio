import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/portfolio_screen.dart';

void main() {
  testWidgets('Finds a Button with text "Coming Soon"', (
    WidgetTester tester,
  ) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      PortfolioScreen(
        title: '',
        onThemeColorChanged: (Color color) {},
        currentThemeColor: Colors.black,
      ),
    );

    // Verify that a Button with the text "Push Me" is present.
    expect(find.widgetWithText(ElevatedButton, 'Coming Soon'), findsOneWidget);
  });

  testWidgets('AppBar IconButton has correct iconSize and color', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      PortfolioScreen(
        title: '',
        onThemeColorChanged: (Color color) {},
        currentThemeColor: Colors.black,
      ),
    );

    // Find the IconButton by its icon.
    final iconButtonFinder = find.widgetWithIcon(IconButton, Icons.color_lens);
    expect(iconButtonFinder, findsOneWidget);

    // Get the IconButton widget.
    final IconButton iconButton = tester.widget(iconButtonFinder);

    // Verify the iconSize.
    expect(iconButton.iconSize, 30.0);

    // Verify the icon color.
    // We need the context from the AppBar to correctly get the theme color.
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);
    final BuildContext appBarContext = tester.element(appBarFinder);

    // Get the Icon widget from the IconButton.
    final Icon iconWidget = iconButton.icon as Icon;

    // Verify the color of the Icon.
    expect(iconWidget.color, Theme.of(appBarContext).colorScheme.onPrimary);
  });
}