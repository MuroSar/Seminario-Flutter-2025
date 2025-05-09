import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:seminario_flutter/data/models/characters_response.dart';

import '../../../../core/credentials.dart';
import '../../../models/movie_response.dart';
import '../interfaces/i_api_service.dart';

class ApiService implements IApiService {
  static const String _apiKey = '?api_key=';

  static const String _apiKeyValue = Credentials.apiKeyValue;

  @override
  Future<CharacterResponse> getCharacters({required String endpoint}) async {
    final response = await http.get(Uri.parse('$endpoint$_apiKey$_apiKeyValue'));
    if (response.statusCode == HttpStatus.ok) {
      return CharacterResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Future<MovieResponse> getMoviesByType({required String endpoint}) async {
    final response = await http.get(Uri.parse('$endpoint$_apiKey$_apiKeyValue'));

    if (response.statusCode == HttpStatus.ok) {
      var movieResponse = MovieResponse.fromJson(jsonDecode(response.body));
      return movieResponse;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
