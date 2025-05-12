// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  CharacterDao? _characterDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`adult` INTEGER, `backdropPath` TEXT, `id` INTEGER, `originalLanguage` TEXT, `originalTitle` TEXT, `overview` TEXT, `popularity` INTEGER, `posterPath` TEXT, `releaseDate` TEXT, `title` TEXT, `video` INTEGER, `voteAverage` INTEGER, `voteCount` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Character` (`adult` INTEGER, `gender` INTEGER, `id` INTEGER, `knownForDepartment` TEXT, `name` TEXT, `originalName` TEXT, `popularity` INTEGER, `profilePath` TEXT, `knownFor` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  CharacterDao get characterDao {
    return _characterDaoInstance ??= _$CharacterDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'popularity': item.popularity,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'title': item.title,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<List<Movie>> getAllMovies() async {
    return _queryAdapter.queryList('Select * from Movie',
        mapper: (Map<String, Object?> row) => Movie(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as int?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            title: row['title'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as int?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    return _queryAdapter.queryList(
        'Select * from Movie ORDER BY popularity DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => Movie(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as int?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            title: row['title'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as int?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    return _queryAdapter.queryList(
        'Select * from Movie ORDER BY voteAverage DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => Movie(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as int?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            title: row['title'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as int?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.replace);
  }
}

class _$CharacterDao extends CharacterDao {
  _$CharacterDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _characterInsertionAdapter = InsertionAdapter(
            database,
            'Character',
            (Character item) => <String, Object?>{
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'gender': item.gender,
                  'id': item.id,
                  'knownForDepartment': item.knownForDepartment,
                  'name': item.name,
                  'originalName': item.originalName,
                  'popularity': item.popularity,
                  'profilePath': item.profilePath,
                  'knownFor': item.knownFor
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Character> _characterInsertionAdapter;

  @override
  Future<void> getCharacters() async {
    await _queryAdapter.queryNoReturn('SELECT * FROM Character LIMIT 20');
  }

  @override
  Future<void> insertCharacter(Character character) async {
    await _characterInsertionAdapter.insert(
        character, OnConflictStrategy.replace);
  }
}
