import 'package:seminario_flutter/data/datasource/local/interfaces/i_local_database.dart';
import 'package:seminario_flutter/data/models/characters_response.dart';
import 'package:seminario_flutter/domain/entities/character.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/i_characters_repository.dart';
import '../datasource/remote/interfaces/i_api_service.dart';

class CharactersRepository implements ICharactersRepository {
  CharactersRepository({
    required this.apiService,
    required this.databaseService,
  });

  final IApiService apiService;
  final ILocalDatabase databaseService;

  @override
  Future<List<Character>> getCharacters(String endpoint) async {
    final connectivity = await Connectivity().checkConnectivity();

    try {
      if (connectivity.contains(ConnectivityResult.none)) {
        return await databaseService.getCharacter();
      } else {
        final CharacterResponse response = await apiService.getCharacters(
          endpoint: endpoint,
        );
        for (final Character character in response.results) {
          await databaseService.insertCharacter(character);
        }
        return response.results;
      }

    } catch (error) {
      throw Exception('Error connecting with the API');
    }
  }
}
