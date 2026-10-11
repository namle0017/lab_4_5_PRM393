import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_basics_demo.dart';
import 'app_structure_theme_demo.dart';
import 'common_errors_fix_demo.dart';

/// Lab 4 Exercise Menu Screen
/// Connects all five Lab 4 exercises with Navigator.push & MaterialPageRoute.
class Lab4MenuScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;

  const Lab4MenuScreen({
    super.key,
    this.isDarkMode = false,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final exercises = [
      {
        'title': 'Exercise 1: Core Widgets',
        'subtitle': 'Text, Material Icons, Network Image, Card & ListTile',
        'icon': Icons.widgets_outlined,
        'color': Colors.blue,
        'builder': (BuildContext ctx) => const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2: Input Widgets',
        'subtitle': 'Slider, Switch, RadioListTile, and DatePicker with state',
        'icon': Icons.tune_rounded,
        'color': Colors.teal,
        'builder': (BuildContext ctx) => const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3: Layout Composition',
        'subtitle': 'Column, Row, consistent Padding (8/12/16px), & ListView.builder',
        'icon': Icons.dashboard_outlined,
        'color': Colors.indigo,
        'builder': (BuildContext ctx) => const LayoutBasicsDemo(),
      },
      {
        'title': 'Exercise 4: App Structure & Theme',
        'subtitle': 'Scaffold, AppBar, Body, FAB, and Dark Mode theme toggle',
        'icon': Icons.palette_outlined,
        'color': Colors.deepPurple,
        'builder': (BuildContext ctx) => AppStructureThemeDemo(
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
      },
      {
        'title': 'Exercise 5: Debug & Fix UI Errors',
        'subtitle': 'Expanded in Column, SingleChildScrollView, setState, DatePicker context',
        'icon': Icons.bug_report_outlined,
        'color': Colors.deepOrange,
        'builder': (BuildContext ctx) => const CommonErrorsFixDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4: UI Fundamentals'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header info card
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      'Module 4 Exercises',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore each individual exercise below. Tap on any card to navigate using Flutter Navigator.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // Exercise cards list
          ...exercises.map((ex) {
            final color = ex['color'] as Color;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.15),
                    radius: 24,
                    child: Icon(ex['icon'] as IconData, color: color),
                  ),
                  title: Text(
                    ex['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(ex['subtitle'] as String),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    // Navigate to individual exercise using Navigator.push + MaterialPageRoute
                    final builder = ex['builder'] as Widget Function(BuildContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: builder),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
