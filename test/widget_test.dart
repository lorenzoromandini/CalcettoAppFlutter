// This is a basic Flutter widget test for the Calcetto app.

import 'package:flutter_test/flutter_test.dart';
import 'package:calcetto_app/core/app/app.dart';

void main() {
  testWidgets('App shows Calcetto title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalcettoApp());

    // Verify that the app title is displayed.
    expect(find.text('Calcetto'), findsOneWidget);
  });
}
