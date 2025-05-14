import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:seminario_flutter/data/datasource/remote/interfaces/i_api_service.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';
import 'package:seminario_flutter/domain/repositories/i_movies_repository.dart';

import '../datasource/local/interfaces/i_local_database.dart';
import '../models/movie_response.dart';

class MoviesRepository implements IMoviesRepository {
  MoviesRepository({
    required this.apiService,
    required this.databaseService,
    connectivityPlugin,
  }) : connectivity = connectivityPlugin ?? Connectivity();

  final IApiService apiService;
  final ILocalDatabase databaseService;
  final Connectivity connectivity; 

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return await databaseService.getPopularMovies();
      } else {
        final MovieResponse response = await apiService.getPopularMovies();

        for (final Movie movie in response.results) {
          await databaseService.insertMovie(movie);
        }
        return response.results;
      }
    } catch (error) {
      throw Exception('Error connecting with the API');
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();

      if (connectivity.contains(ConnectivityResult.none)) {
        return await databaseService.getPopularMovies();
      } else {
        final MovieResponse response = await apiService.getTopRatedMovies();
        for (final Movie movie in response.results) {
          await databaseService.insertMovie(movie);
        }
        return response.results;
      }
    } catch (error) {
      throw Exception('Error connecting with the API');
    }
  }
}
