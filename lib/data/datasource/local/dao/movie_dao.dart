import 'package:floor/floor.dart';

import '../../../../domain/entities/movie.dart';

@dao
abstract class MovieDao {
  @Query('Select * from Movie')
  Future<List<Movie>> getAllMovies();

  @Query('Select * from Movie ORDER BY popularity DESC LIMIT 20')
  Future<List<Movie>> getPopularMovies();

  @Query('Select * from Movie ORDER BY voteAverage DESC LIMIT 20')
  Future<List<Movie>> getTopRatedMovies();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
