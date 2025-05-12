import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/entities/character.dart';
import '../../../domain/entities/movie.dart';
import 'dao/character_dao.dart';
import 'dao/movie_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Movie, Character])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  CharacterDao get characterDao;
}
