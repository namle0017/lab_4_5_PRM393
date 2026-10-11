/// Model representing a Movie Trailer
class Trailer {
  final String id;
  final String title;
  final String duration;
  final String thumbnailUrl;

  const Trailer({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
  });
}

/// Model representing a Movie for Lab 5 Movie Detail App
class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final int releaseYear;
  final String runtime;
  final List<Trailer> trailers;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.releaseYear,
    required this.runtime,
    required this.trailers,
    this.isFavorite = false,
  });
}
