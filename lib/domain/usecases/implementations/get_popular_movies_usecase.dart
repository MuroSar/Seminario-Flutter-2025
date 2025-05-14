import 'package:seminario_flutter/domain/entities/movie.dart';
import 'package:seminario_flutter/domain/repositories/i_movies_repository.dart';
import 'package:seminario_flutter/domain/usecases/interfaces/i_usecase.dart';

class GetPopularMoviesUseCase implements IUseCase {
  GetPopularMoviesUseCase(this.repository);

  final IMoviesRepository repository;

  @override
  Future<List<Movie>> call() async {
    return await repository.getPopularMovies();
  }
}
