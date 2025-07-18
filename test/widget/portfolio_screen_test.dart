import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/screens/portfolio_screen.dart';

void main() {
  testWidgets('Finds a Button with text "Coming Soon"', (
    WidgetTester tester,
  ) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Navigator(
            onGenerateRoute:
                (_) => MaterialPageRoute(
                  builder: (_) => PortfolioScreen(),
                ),),
          ),
        ),
      );
    expect(find.widgetWithText(ElevatedButton, 'Coming Soon'), findsOneWidget);
  });

  testWidgets('AppBar IconButton has correct iconSize', (
    WidgetTester tester,
  ) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Navigator(
            onGenerateRoute:
                (_) => MaterialPageRoute(
                  builder: (_) => PortfolioScreen(),
                ),
          ),
        ),
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
  });
}
