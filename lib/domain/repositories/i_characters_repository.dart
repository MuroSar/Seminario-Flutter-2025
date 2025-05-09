import 'package:seminario_flutter/domain/entities/character.dart';

abstract class ICharactersRepository {
  Future<List<Character>> getCharacters(String endpoint);
}
