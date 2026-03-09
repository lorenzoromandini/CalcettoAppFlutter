// This is a basic Flutter widget test for the Calcetto app.

import 'package:flutter_test/flutter_test.dart';
import 'package:calcetto_app/core/app/app.dart';

void main() {
  testWidgets('CalcettoApp widget renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalcettoApp());

    // Verify app initializes
    expect(find.byType(CalcettoApp), findsOneWidget);
  });
}
