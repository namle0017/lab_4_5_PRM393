import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'lab4/lab4_menu_screen.dart';
import 'lab4/core_widgets_demo.dart';
import 'lab4/input_controls_demo.dart';
import 'lab4/layout_basics_demo.dart';
import 'lab4/app_structure_theme_demo.dart';
import 'lab4/common_errors_fix_demo.dart';
import 'lab5/movie_home_screen.dart';
import 'lab5/movie_detail_screen.dart';

/// Centralized Router for Lab 4 & Lab 5 Navigation
class AppRouter {
  static const String home = '/';
  static const String lab4Menu = '/lab4';
  static const String lab4CoreWidgets = '/lab4/core_widgets';
  static const String lab4InputControls = '/lab4/input_controls';
  static const String lab4LayoutBasics = '/lab4/layout_basics';
  static const String lab4AppStructure = '/lab4/app_structure';
  static const String lab4CommonErrors = '/lab4/common_errors';
  static const String movies = '/movies';
  static const String movieDetail = '/movie_detail';

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings, {
    required bool isDarkMode,
    required ValueChanged<bool> onThemeChanged,
  }) {
    switch (settings.name) {
      case lab4Menu:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Lab4MenuScreen(
            isDarkMode: isDarkMode,
            onThemeChanged: onThemeChanged,
          ),
        );

      case lab4CoreWidgets:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CoreWidgetsDemo(),
        );

      case lab4InputControls:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const InputControlsDemo(),
        );

      case lab4LayoutBasics:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LayoutBasicsDemo(),
        );

      case lab4AppStructure:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AppStructureThemeDemo(
            isDarkMode: isDarkMode,
            onThemeChanged: onThemeChanged,
          ),
        );

      case lab4CommonErrors:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CommonErrorsFixDemo(),
        );

      case movies:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MovieHomeScreen(),
        );

      case movieDetail:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MovieDetailScreen(movie: movie),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
