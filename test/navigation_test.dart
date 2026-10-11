import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_4_5_se194800/app_router.dart';
import 'package:lab_4_5_se194800/main.dart';
import 'package:lab_4_5_se194800/data/sample_data.dart';

void main() {
  group('Navigator & AppRouter Tests', () {
    testWidgets('Drawer opens and navigates directly to Lab 4 Ex 1 via named route', (tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pumpAndSettle();

      // Open Drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pumpAndSettle();

      // Verify drawer header and shortcuts
      expect(find.text('Student: SE194800'), findsOneWidget);
      expect(find.text('Ex 1: Core Widgets'), findsOneWidget);

      // Tap on Ex 1 shortcut
      await tester.tap(find.text('Ex 1: Core Widgets'));
      await tester.pumpAndSettle();

      // Verify CoreWidgetsDemo screen is displayed
      expect(find.text('Ex 1: Core Widgets'), findsOneWidget);
      expect(find.text('Flutter Core Widgets Showcase'), findsOneWidget);

      // Navigate back using Navigator.pop
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Back to Home
      expect(find.text('Movies'), findsOneWidget);
    });

    testWidgets('Navigating to MovieDetailScreen using named route with arguments works', (tester) async {
      final sampleMovie = sampleMovies.first;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
            settings,
            isDarkMode: false,
            onThemeChanged: (_) {},
          ),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.movieDetail,
                      arguments: sampleMovie,
                    );
                  },
                  child: const Text('Open Movie Detail'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap button to navigate
      await tester.tap(find.text('Open Movie Detail'));
      await tester.pumpAndSettle();

      // Verify Movie Detail screen is displayed for sample movie
      expect(find.text(sampleMovie.title), findsWidgets);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text(sampleMovie.overview), findsOneWidget);
    });
  });
}
