import 'package:seminario_flutter/data/models/characters_response.dart';
import 'package:seminario_flutter/data/models/movie_response.dart';

abstract class IApiService {
  Future<MovieResponse> getPopularMovies();

  Future<MovieResponse> getTopRatedMovies();

  Future<CharacterResponse> getCharacters({required String endpoint});
}
