import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_4_5_se194800/lab4/core_widgets_demo.dart';
import 'package:lab_4_5_se194800/lab4/input_controls_demo.dart';
import 'package:lab_4_5_se194800/lab4/layout_basics_demo.dart';
import 'package:lab_4_5_se194800/lab4/app_structure_theme_demo.dart';
import 'package:lab_4_5_se194800/lab4/common_errors_fix_demo.dart';

void main() {
  group('Lab 4 Exercises Tests', () {
    testWidgets('Ex 1: CoreWidgetsDemo renders all required widgets', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CoreWidgetsDemo()));
      await tester.pump();

      // Check headline text
      expect(find.text('Flutter Core Widgets Showcase'), findsOneWidget);

      // Check Icons
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);

      // Check Card and ListTile
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Premiere Night: Interstellar'), findsOneWidget);
    });

    testWidgets('Ex 2: InputControlsDemo updates state when controls change', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: InputControlsDemo()));
      await tester.pump();

      // Verify controls exist
      expect(find.byType(Slider), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.text('Standard Seat'), findsOneWidget);
      expect(find.text('Pick Booking Date (${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year})'), findsOneWidget);

      // Toggle switch
      await tester.tap(find.byType(SwitchListTile));
      await tester.pump();
      expect(find.text('• Notifications: Disabled (OFF)'), findsOneWidget);
    });

    testWidgets('Ex 3: LayoutBasicsDemo renders sections and ListView', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LayoutBasicsDemo()));
      await tester.pump();

      // Verify section titles
      expect(find.text('Welcome to CinemaHub'), findsOneWidget);
      expect(find.text('Browse Categories'), findsOneWidget);
      expect(find.text('Popular Titles (ListView.builder)'), findsOneWidget);
      expect(find.text('Inception'), findsOneWidget);
    });

    testWidgets('Ex 4: AppStructureThemeDemo renders Scaffold, FAB and toggles dark mode', (tester) async {
      bool darkValue = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AppStructureThemeDemo(
            isDarkMode: false,
            onThemeChanged: (val) => darkValue = val,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Dark Mode Toggle'), findsOneWidget);

      // Tap FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('Action (1)'), findsOneWidget);

      // Toggle Dark Mode
      await tester.tap(find.byType(SwitchListTile));
      await tester.pump();
      expect(darkValue, true);
    });

    testWidgets('Ex 5: CommonErrorsFixDemo switches error tabs and increments counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CommonErrorsFixDemo()));
      await tester.pump();

      expect(find.text('Lab 4 - Exercise 5: Debugging Lab'), findsOneWidget);
      expect(find.text('Bug 1: ListView inside Column (Unbounded Height)'), findsOneWidget);

      // Tap tab 3 (setState)
      await tester.tap(find.text('3. setState'));
      await tester.pump();

      final incrementBtn = find.text('Increment (with setState)');
      await tester.ensureVisible(incrementBtn);
      await tester.pumpAndSettle();
      await tester.tap(incrementBtn);
      await tester.pump();
      expect(find.text('Live Counter Value: 1'), findsOneWidget);
    });
  });
}
