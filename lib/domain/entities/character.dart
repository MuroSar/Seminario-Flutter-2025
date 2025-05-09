import 'movie.dart';

class Character {
  final bool? adult;
  final int? gender;
  final num? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final num? popularity;
  final String? profilePath;
  final List<Movie>? knownFor;

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
      knownFor: fromList(json['known_for']),
    );
  }

  static List<Movie> fromList(List<dynamic> json) {
    return List<Movie>.from(json.map((movie) => Movie.fromJson(movie)));
  }
}
