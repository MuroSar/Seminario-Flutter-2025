import '../../repositories/i_movies_repository.dart';
import '../interfaces/i_usecase.dart';

class GetTopRatedMoviesUseCase implements IUseCase {
  GetTopRatedMoviesUseCase(this.repository);

  final IMoviesRepository repository;

  @override
  Future call() async {
    return await repository.getTopRatedMovies();
  }
}
