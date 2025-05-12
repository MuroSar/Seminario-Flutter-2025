import '../../../../domain/entities/character.dart';
import '../../../../domain/entities/movie.dart';

abstract class ILocalDatabase {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Character>> getCharacter();
  Future<void> insertMovie(Movie movie);
  Future<void> insertCharacter(Character character);
}
