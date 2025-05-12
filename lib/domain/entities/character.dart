import 'dart:convert';

import 'package:floor/floor.dart';

import 'movie.dart';

@entity
class Character {
  final bool? adult;
  final int? gender;
  @primaryKey
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final int? popularity;
  final String? profilePath;
  final String? knownFor;

  Character({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  String get fullProfilePath => 'https://image.tmdb.org/t/p/w500/$profilePath';
  List<Movie> get knowForMovies => fromList(jsonDecode(knownFor!));

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
      knownFor: jsonEncode(json['known_for']),
    );
  }

  static List<Movie> fromList(List<dynamic> json) {
    return List<Movie>.from(json.map((movie) => Movie.fromJson(movie)));
  }
}
