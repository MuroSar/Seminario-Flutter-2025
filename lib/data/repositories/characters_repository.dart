import 'package:seminario_flutter/data/models/characters_response.dart';
import 'package:seminario_flutter/domain/entities/character.dart';

import '../../domain/repositories/i_characters_repository.dart';
import '../datasource/remote/interfaces/i_api_service.dart';

class CharactersRepository implements ICharactersRepository {
  CharactersRepository({required this.apiService});

  final IApiService apiService;

  @override
  Future<List<Character>> getCharacters(String endpoint) async {
    try {
      final CharacterResponse response = await apiService.getCharacters(
        endpoint: endpoint,
      );

      return response.results;
    } catch (error) {
      throw Exception('Error connecting with the API');
    }
  }
}
