import 'package:flutter/material.dart';
import 'app_router.dart';
import 'lab4/lab4_menu_screen.dart';
import 'lab5/movie_home_screen.dart';

void main() {
  runApp(const MainApp());
}

/// Root Application Widget with dynamic Light / Dark Theme Mode
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _updateThemeMode(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      title: 'Lab 4 & 5 - PRM392 (SE194800)',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),

      // Dark Theme (Lab 4 Exercise 4)
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),

      // Centralized Navigation Routes
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
        settings,
        isDarkMode: isDark,
        onThemeChanged: _updateThemeMode,
      ),

      // Main Navigation Shell
      home: MainShellScreen(
        isDarkMode: isDark,
        onThemeChanged: _updateThemeMode,
      ),
    );
  }
}

/// Main Shell Screen providing Navigation Drawer & BottomNavigationBar
/// connecting Lab 4 (UI Fundamentals) and Lab 5 (Movie Detail App)
class MainShellScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainShellScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Two main tabs
    final List<Widget> screens = [
      const MovieHomeScreen(),
      Lab4MenuScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      // Global Drawer connecting all Lab 4 & Lab 5 screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'Student: SE194800',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: const Text('PRM392 - Flutter Labs 4 & 5'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimary,
                child: Icon(Icons.movie_filter_rounded, size: 36, color: theme.colorScheme.primary),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Lab 5: Movie Detail App'),
              selected: _currentIndex == 0,
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets_outlined),
              title: const Text('Lab 4: All Exercises Menu'),
              selected: _currentIndex == 1,
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'DIRECT EXERCISE SHORTCUTS',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.looks_one_outlined),
              title: const Text('Ex 1: Core Widgets'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.lab4CoreWidgets);
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_two_outlined),
              title: const Text('Ex 2: Input Controls'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.lab4InputControls);
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_3_outlined),
              title: const Text('Ex 3: Layout Composition'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.lab4LayoutBasics);
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_4_outlined),
              title: const Text('Ex 4: App Structure & Theme'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.lab4AppStructure);
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_5_outlined),
              title: const Text('Ex 5: Debug & Fix UI Errors'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.lab4CommonErrors);
              },
            ),
            const Divider(),
            // Quick Dark Mode Toggle inside Drawer
            SwitchListTile(
              secondary: Icon(
                widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: widget.isDarkMode ? Colors.amber : Colors.blue,
              ),
              title: const Text('Dark Mode'),
              value: widget.isDarkMode,
              onChanged: (val) {
                widget.onThemeChanged(val);
              },
            ),
          ],
        ),
      ),

      // Active screen from selected tab
      body: screens[_currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: 'Lab 5 (Movies)',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Lab 4 (UI Basics)',
          ),
        ],
      ),
    );
  }
}
