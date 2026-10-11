import 'package:flutter/material.dart';

/// Exercise 3 – Layout Basics: Column, Row, Padding, ListView
/// Goal: Build a sectioned UI layout similar to a real app Home screen with consistent spacing (8, 12, 16 px).
class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final featuredCategories = [
      {'icon': Icons.local_fire_department, 'label': 'Trending'},
      {'icon': Icons.new_releases, 'label': 'New Releases'},
      {'icon': Icons.workspace_premium, 'label': 'Top Rated'},
      {'icon': Icons.upcoming, 'label': 'Coming Soon'},
    ];

    final movieList = [
      {'title': 'Inception', 'year': '2010', 'genre': 'Sci-Fi • Thriller', 'rating': '8.8'},
      {'title': 'Interstellar', 'year': '2014', 'genre': 'Adventure • Drama', 'rating': '8.7'},
      {'title': 'The Dark Knight', 'year': '2008', 'genre': 'Action • Crime', 'rating': '9.0'},
      {'title': 'Spirited Away', 'year': '2001', 'genre': 'Animation • Fantasy', 'rating': '8.6'},
      {'title': 'Dune: Part Two', 'year': '2024', 'genre': 'Sci-Fi • Adventure', 'rating': '8.9'},
      {'title': 'Oppenheimer', 'year': '2023', 'genre': 'Biography • Drama', 'rating': '8.9'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex 3: Layout Composition'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Header banner section using Row & Padding (16 px)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to CinemaHub',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Explore movies with structured layouts',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  radius: 24,
                  child: Icon(Icons.person, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),

          // Section 2: Quick Filter Categories using horizontal Row / ListView (12 px spacing)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Browse Categories',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: featuredCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final cat = featuredCategories[index];
                return Chip(
                  avatar: Icon(cat['icon'] as IconData, size: 18),
                  label: Text(cat['label'] as String),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );
              },
            ),
          ),

          const SizedBox(height: 16.0),

          // Section 3: Movie List section header (16 px horizontal padding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Titles (ListView.builder)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${movieList.length} Items',
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),

          // Section 4: Scrollable list using Expanded + ListView.builder (demonstrating proper Column nesting)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                final item = movieList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // Consistent 12px spacing
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Consistent 12px inner padding
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 64,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.movie,
                              color: theme.colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12.0), // Consistent 12px spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${item['year']} • ${item['genre']}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4.0),
                              Text(
                                item['rating']!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
