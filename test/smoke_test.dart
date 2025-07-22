import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app builds without crashing.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
