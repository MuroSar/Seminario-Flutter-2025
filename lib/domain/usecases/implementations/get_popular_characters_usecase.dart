import 'package:seminario_flutter/core/api_constants.dart';
import 'package:seminario_flutter/domain/repositories/i_characters_repository.dart';
import 'package:seminario_flutter/domain/usecases/interfaces/i_usecase.dart';

class GetPopularCharactersUseCase implements IUseCase {
  GetPopularCharactersUseCase(this.repository);

  final ICharactersRepository repository;

  @override
  Future call() async {
    return await repository.getCharacters(
      ApiConstants.popularCharactersEndpoint,
    );
  }
}
