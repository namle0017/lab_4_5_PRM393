import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_4_5_se194800/models/movie.dart';
import 'package:lab_4_5_se194800/lab5/movie_home_screen.dart';
import 'package:lab_4_5_se194800/lab5/movie_detail_screen.dart';

void main() {
  final testMovie = Movie(
    id: 'test_1',
    title: 'Test Movie Title',
    posterUrl: 'https://example.com/poster.jpg',
    backdropUrl: 'https://example.com/backdrop.jpg',
    overview: 'This is a test movie overview description.',
    genres: ['Action', 'Sci-Fi'],
    rating: 8.5,
    releaseYear: 2024,
    runtime: '2h 10m',
    isFavorite: false,
    trailers: const [
      Trailer(
        id: 'tr_1',
        title: 'Teaser 1',
        duration: '1:30',
        thumbnailUrl: 'https://example.com/thumb.jpg',
      ),
    ],
  );

  group('Lab 5 Movie Detail App Tests', () {
    testWidgets('MovieHomeScreen renders movie list and filters by search', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieHomeScreen(initialMovies: [testMovie]),
        ),
      );
      await tester.pump();

      // Check title and rating
      expect(find.text('Test Movie Title'), findsOneWidget);
      expect(find.text('8.5'), findsOneWidget);

      // Search query matching
      await tester.enterText(find.byType(TextField), 'Test');
      await tester.pump();
      expect(find.text('Test Movie Title'), findsOneWidget);

      // Search query not matching
      await tester.enterText(find.byType(TextField), 'NonexistentMovieXYZ');
      await tester.pump();
      expect(find.text('Test Movie Title'), findsNothing);
      expect(find.textContaining('No movies found matching'), findsOneWidget);
    });

    testWidgets('MovieDetailScreen displays details and toggles favorite', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );
      await tester.pump();

      // Verify title, overview, chips
      expect(find.text('Test Movie Title'), findsWidgets);
      expect(find.text('This is a test movie overview description.'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
      expect(find.text('Sci-Fi'), findsOneWidget);
      expect(find.text('Teaser 1'), findsOneWidget);

      // Toggle favorite via AppBar action
      await tester.tap(find.byTooltip('Favorite'));
      await tester.pump();
      expect(testMovie.isFavorite, true);
    });

    testWidgets('Navigation from MovieHomeScreen to MovieDetailScreen and back works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieHomeScreen(initialMovies: [testMovie]),
        ),
      );
      await tester.pump();

      // Tap on the movie card to navigate
      await tester.tap(find.text('Test Movie Title'));
      await tester.pumpAndSettle();

      // Verify MovieDetailScreen is opened
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Trailers & Teasers (1)'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Back on MovieHomeScreen
      expect(find.text('Movies'), findsOneWidget);
    });
  });
}
