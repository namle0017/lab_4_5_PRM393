import '../models/movie.dart';

/// Sample movie data for Lab 5 and Lab 4 exercises
final List<Movie> sampleMovies = [
  Movie(
    id: 'm1',
    title: 'Inception',
    posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&auto=format&fit=crop&q=80',
    backdropUrl: 'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?w=1200&auto=format&fit=crop&q=80',
    overview:
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster.',
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    rating: 8.8,
    releaseYear: 2010,
    runtime: '2h 28m',
    isFavorite: true,
    trailers: const [
      Trailer(
        id: 't1_1',
        title: 'Official Trailer #1 (HD)',
        duration: '2:31',
        thumbnailUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500&auto=format&fit=crop&q=80',
      ),
      Trailer(
        id: 't1_2',
        title: 'Teaser Trailer: Mind Heist',
        duration: '1:45',
        thumbnailUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=500&auto=format&fit=crop&q=80',
      ),
    ],
  ),
  Movie(
    id: 'm2',
    title: 'Interstellar',
    posterUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&auto=format&fit=crop&q=80',
    backdropUrl: 'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?w=1200&auto=format&fit=crop&q=80',
    overview:
        'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    rating: 8.7,
    releaseYear: 2014,
    runtime: '2h 49m',
    isFavorite: false,
    trailers: const [
      Trailer(
        id: 't2_1',
        title: 'Official Teaser Trailer',
        duration: '1:52',
        thumbnailUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=500&auto=format&fit=crop&q=80',
      ),
      Trailer(
        id: 't2_2',
        title: 'Official Final Trailer (IMAX)',
        duration: '2:24',
        thumbnailUrl: 'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?w=500&auto=format&fit=crop&q=80',
      ),
    ],
  ),
  Movie(
    id: 'm3',
    title: 'The Dark Knight',
    posterUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=800&auto=format&fit=crop&q=80',
    backdropUrl: 'https://images.unsplash.com/photo-1514306191717-452ec28c7814?w=1200&auto=format&fit=crop&q=80',
    overview:
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    genres: ['Action', 'Crime', 'Drama'],
    rating: 9.0,
    releaseYear: 2008,
    runtime: '2h 32m',
    isFavorite: true,
    trailers: const [
      Trailer(
        id: 't3_1',
        title: 'Theatrical Trailer',
        duration: '2:15',
        thumbnailUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500&auto=format&fit=crop&q=80',
      ),
      Trailer(
        id: 't3_2',
        title: 'Why So Serious? Featurette',
        duration: '3:05',
        thumbnailUrl: 'https://images.unsplash.com/photo-1514306191717-452ec28c7814?w=500&auto=format&fit=crop&q=80',
      ),
    ],
  ),
  Movie(
    id: 'm4',
    title: 'Spirited Away',
    posterUrl: 'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=800&auto=format&fit=crop&q=80',
    backdropUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=1200&auto=format&fit=crop&q=80',
    overview:
        'During her family\'s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.',
    genres: ['Animation', 'Adventure', 'Family', 'Fantasy'],
    rating: 8.6,
    releaseYear: 2001,
    runtime: '2h 5m',
    isFavorite: false,
    trailers: const [
      Trailer(
        id: 't4_1',
        title: 'Studio Ghibli 20th Anniversary Trailer',
        duration: '1:58',
        thumbnailUrl: 'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=500&auto=format&fit=crop&q=80',
      ),
    ],
  ),
];
