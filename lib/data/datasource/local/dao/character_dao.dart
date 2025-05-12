import 'package:floor/floor.dart';

import '../../../../domain/entities/character.dart';

@dao
abstract class CharacterDao {
  @Query('SELECT * FROM Character LIMIT 20')
  Future<Character> getCharacters();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCharacter(Character character);
}