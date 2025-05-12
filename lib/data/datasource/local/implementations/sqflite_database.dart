import 'package:floor/floor.dart';
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

    final List<Character> characters = [];

    characters.addAll();

    return [];
  }

  @override
  Future<List<Movie>> getPopularMovies() {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getTopRatedMovies() {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

}