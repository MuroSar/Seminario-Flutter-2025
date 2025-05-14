import 'package:flutter_test/flutter_test.dart';
import 'package:seminario_flutter/data/models/movie_response.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';

void main() {
  late Map<String, dynamic> movieResponseJson;

  setUp(
    () => {
      movieResponseJson = {
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg",
            "genre_ids": [28, 12, 878],
            "id": 640146,
            "original_language": "en",
            "original_title": "Ant-Man and the Wasp: Quantumania",
            "overview":
                "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.",
            "popularity": 8567.865,
            "poster_path": "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg",
            "release_date": "2023-02-15",
            "title": "Ant-Man and the Wasp: Quantumania",
            "video": false,
            "vote_average": 6.5,
            "vote_count": 1886,
          },
          {
            "adult": false,
            "backdrop_path": "/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg",
            "genre_ids": [16, 12, 10751, 14, 35],
            "id": 502356,
            "original_language": "en",
            "original_title": "The Super Mario Bros. Movie",
            "overview":
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
            "popularity": 6572.614,
            "poster_path": "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
            "release_date": "2023-04-05",
            "title": "The Super Mario Bros. Movie",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 1456,
          },
        ],
        "total_pages": 38029,
        "total_results": 760569,
      },
    },
  );

  test("Should return a MovieResponse instance when fromJson is called", () {
    final result = MovieResponse.fromJson(movieResponseJson);

    expect(result, isInstanceOf<MovieResponse>());
  });

  test("Should return a List of Movies when fromList is called", () {
    final jsonResults = movieResponseJson["results"];
    final result = MovieResponse.fromList(jsonResults);
    expect(result, isA<List<Movie>>());
    expect(result, hasLength(2));
  });
}
