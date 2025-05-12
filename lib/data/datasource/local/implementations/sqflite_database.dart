import 'package:seminario_flutter/data/datasource/local/interfaces/i_local_database.dart';
import 'package:seminario_flutter/domain/entities/character.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';

import '../database.dart';

class SqfliteDatabase extends ILocalDatabase {
  static SqfliteDatabase? _instance;
  final AppDatabase database;

  SqfliteDatabase._(this.database);

  static Future<SqfliteDatabase> getInstance() async {
    if (_instance == null) {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      _instance = SqfliteDatabase._(database);
    }
    return _instance!;
  }

  @override
  Future<List<Character>> getCharacter() async {
    final List<Character> result = await database.characterDao.getCharacters();

    return result;
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    final List<Movie> result = await database.movieDao.getPopularMovies();

    return result;
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    final List<Movie> result = await database.movieDao.getTopRatedMovies();

    return result;
  }

  @override
  Future<void> insertCharacter(Character character) async {
    await database.characterDao.insertCharacter(character);
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await database.movieDao.insertMovie(movie);
  }
}
