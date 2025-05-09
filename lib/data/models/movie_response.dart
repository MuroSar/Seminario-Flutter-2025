import '../../domain/entities/movie.dart';

class MovieResponse {
  List<Movie> results;
  int page;
  int totalPages;
  int totalResult;

  MovieResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResult,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    results: fromList(json['results']),
    page: json['page'],
    totalPages: json['total_pages'],
    totalResult: json['total_results'],
  );

  static List<Movie> fromList(List<dynamic> json) {
    return List<Movie>.from(json.map((movie) => Movie.fromJson(movie)));
  }
}
