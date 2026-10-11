import 'package:flutter/material.dart';

/// Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile
/// Goal: Build a simple UI demonstrating essential Flutter display widgets.
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex 1: Core Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Headline Text widget
            Text(
              'Flutter Core Widgets Showcase',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Demonstrating essential Flutter display widgets: Headline Text, Material Icons, Network Images, Cards, and ListTiles.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24.0),

            // 2. Icon using Material Icons with styling
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 36,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(width: 8.0),
                Icon(
                  Icons.movie_creation_outlined,
                  size: 36,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8.0),
                Icon(
                  Icons.favorite_rounded,
                  size: 36,
                  color: Colors.red.shade400,
                ),
                const SizedBox(width: 12.0),
                Text(
                  'Material Icons Row',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // 3. Image.network() with loading & error fallback
            Text(
              'Network Image Display:',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=80',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Image loaded fallback'),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24.0),

            // 4. Card containing a ListTile
            Text(
              'Card with ListTile:',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.theaters_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                title: const Text(
                  'Premiere Night: Interstellar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Hall 01 • Today at 19:30 • ScreenX 3D'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tapped on Card ListTile!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
