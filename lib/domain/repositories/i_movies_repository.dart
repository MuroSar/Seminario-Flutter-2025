import '../entities/movie.dart';

abstract class IMoviesRepository {
  Future<List<Movie>> getMoviesByType(String endpoint);
}
