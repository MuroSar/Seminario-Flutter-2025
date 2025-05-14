import '../entities/movie.dart';

abstract class IMoviesRepository {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
}
