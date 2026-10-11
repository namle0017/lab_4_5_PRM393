import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_4_5_se194800/main.dart';

void main() {
  testWidgets('App loads successfully and shows Movie and Lab 4 tabs', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    // Verify Lab 5 (Movies) is displayed by default
    expect(find.text('Movies'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    // Switch to Lab 4 tab via bottom navigation
    await tester.tap(find.text('Lab 4 (UI Basics)'));
    await tester.pumpAndSettle();

    // Verify Lab 4 menu is loaded
    expect(find.text('Lab 4: UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1: Core Widgets'), findsOneWidget);
  });
}
