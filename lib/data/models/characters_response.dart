import '../../domain/entities/character.dart';

class CharacterResponse {
  List<Character> results;
  int page;
  int totalPages;
  int totalResult;

  CharacterResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResult,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => CharacterResponse(
    results: fromList(json['results']),
    page: json['page'],
    totalPages: json['total_pages'],
    totalResult: json['total_results'],
  );

  static List<Character> fromList(List<dynamic> json) {
    return List<Character>.from(json.map((character) => Character.fromJson(character)));
  }
}

