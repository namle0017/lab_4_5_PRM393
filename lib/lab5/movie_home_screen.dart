import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../data/sample_data.dart';
import 'movie_detail_screen.dart';

/// Lab 5: Movie Home Screen
/// Displays a scrollable list of movies (poster, title, rating, release year).
/// Supports search filtering and passes the selected Movie object to MovieDetailScreen using Navigator.push.
class MovieHomeScreen extends StatefulWidget {
  final List<Movie>? initialMovies;

  const MovieHomeScreen({super.key, this.initialMovies});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  late List<Movie> _movies;
  late List<Movie> _filteredMovies;
  final TextEditingController _searchController = TextEditingController();
  String _selectedGenre = 'All';

  @override
  void initState() {
    super.initState();
    _movies = widget.initialMovies ?? sampleMovies;
    _filteredMovies = List.from(_movies);
    _searchController.addListener(_filterMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMovies() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredMovies = _movies.where((movie) {
        final matchesQuery = movie.title.toLowerCase().contains(query) ||
            movie.overview.toLowerCase().contains(query);
        final matchesGenre = _selectedGenre == 'All' ||
            movie.genres.contains(_selectedGenre);
        return matchesQuery && matchesGenre;
      }).toList();
    });
  }

  void _onGenreSelected(String genre) {
    setState(() {
      _selectedGenre = genre;
    });
    _filterMovies();
  }

  void _navigateToDetail(Movie movie) async {
    // Navigate using Navigator.push + MaterialPageRoute, passing the selected Movie object
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
    // Refresh state when coming back from detail screen (e.g., if favorite changed)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Extract unique genres for category chips
    final allGenres = ['All', ...{for (var m in _movies) ...m.genres}];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Lab 5 Info',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Lab 5: Movie Detail App'),
                  content: const Text(
                    'This app demonstrates Flutter Navigation (Navigator.push & MaterialPageRoute), '
                    'passing data models (Movie object), Hero animations, and structured UI composition.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies, directors, genres...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // 2. Genre Filter Horizontal List
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: allGenres.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = allGenres[index];
                final isSelected = genre == _selectedGenre;
                return ChoiceChip(
                  label: Text(genre),
                  selected: isSelected,
                  onSelected: (_) => _onGenreSelected(genre),
                  selectedColor: theme.colorScheme.primaryContainer,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // 3. Scrollable List of Movies using ListView.builder
          Expanded(
            child: _filteredMovies.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_filter_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No movies found matching "${_searchController.text}"',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemCount: _filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = _filteredMovies[index];
                      return _MovieCard(
                        movie: movie,
                        onTap: () => _navigateToDetail(movie),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Custom Card Widget for displaying a movie item in the ListView
class _MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _MovieCard({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Movie Poster image
              Hero(
                tag: 'movie-poster-${movie.id}',
                child: SizedBox(
                  width: 110,
                  height: 155,
                  child: Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.movie, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // Movie details text & info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (movie.isFavorite)
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        '${movie.releaseYear} • ${movie.runtime}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      // Genres wrap
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: movie.genres.take(3).map((g) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              g,
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10.0),
                      // Rating & action indicator
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                          const SizedBox(width: 4.0),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            'View Details',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
