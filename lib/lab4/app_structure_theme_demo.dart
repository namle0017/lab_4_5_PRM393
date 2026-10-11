import 'package:flutter/material.dart';

/// Exercise 4 – App Structure with Scaffold, AppBar, FAB & Theme
/// Goal: Practice building a complete screen structure and implement a Dark Mode toggle using themeMode.
class AppStructureThemeDemo extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;

  const AppStructureThemeDemo({
    super.key,
    this.isDarkMode = false,
    this.onThemeChanged,
  });

  @override
  State<AppStructureThemeDemo> createState() => _AppStructureThemeDemoState();
}

class _AppStructureThemeDemoState extends State<AppStructureThemeDemo> {
  late bool _isDark;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDarkMode;
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDark = value;
    });
    if (widget.onThemeChanged != null) {
      widget.onThemeChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // 1. AppBar with theme-aware styling and actions
      appBar: AppBar(
        title: const Text('Ex 4: Structure & Theme'),
        actions: [
          IconButton(
            icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: () => _toggleDarkMode(!_isDark),
          ),
        ],
      ),

      // 2. Body containing structured content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode switch card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                secondary: Icon(
                  _isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: _isDark ? Colors.amber : Colors.blue,
                  size: 32,
                ),
                title: const Text(
                  'Dark Mode Toggle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _isDark ? 'Current Mode: Dark Theme' : 'Current Mode: Light Theme',
                ),
                value: _isDark,
                onChanged: _toggleDarkMode,
              ),
            ),
            const SizedBox(height: 24.0),

            // Demonstration of ThemeData elements
            Text(
              'Active ThemeData Tokens:',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),

            // Color Palette preview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.palette, color: theme.colorScheme.onPrimary),
                        const SizedBox(height: 4),
                        Text(
                          'Primary',
                          style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.brush, color: theme.colorScheme.onSecondary),
                        const SizedBox(height: 4),
                        Text(
                          'Secondary',
                          style: TextStyle(color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.layers, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(height: 4),
                        Text(
                          'Surface',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Scaffold Structure Guide
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.architecture_rounded, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Scaffold Structure Checklist',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text('AppBar'),
                      subtitle: Text('Provides title, leading navigation back button, and theme action buttons.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text('Body'),
                      subtitle: Text('SingleChildScrollView containing responsive Column layout.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text('FloatingActionButton'),
                      subtitle: Text('Prominent floating action at bottom right corner.'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.touch_app, color: Colors.amber),
                      title: Text('FAB Interaction Count: $_tapCount'),
                      subtitle: const Text('Tap the FloatingActionButton below to increment counter.'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. FloatingActionButton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _tapCount++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Floating Action Button clicked! Total taps: $_tapCount'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text('Action ($_tapCount)'),
      ),
    );
  }
}
