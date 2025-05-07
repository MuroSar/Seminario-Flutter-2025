import 'package:seminario_flutter/data/datasource/remote/interfaces/i_api_service.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';
import 'package:seminario_flutter/domain/repositories/i_movies_repository.dart';

import '../models/movie_response.dart';

class MoviesRepository implements IMoviesRepository{
  MoviesRepository({required this.apiService});

  final IApiService apiService;

  @override
  Future<List<Movie>> getMoviesByType(String endpoint) async {

    try{
      final MovieResponse response = await apiService.getMoviesByType(endpoint: endpoint);

      return response.results;
    } catch (error){
      throw Exception('Error connecting with the API');
    }
  }

}