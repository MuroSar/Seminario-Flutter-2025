import 'package:flutter_test/flutter_test.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';

void main() {
  test("Should return a Movie instance when Movie.fromJson is called", () {
    final movieJson = {
      "adult": false,
      "backdrop_path": "/oqP1qEZccq5AD9TVTIaO6IGUj7o.jpg",
      "genre_ids": [14, 28, 12],
      "id": 455476,
      "original_language": "en",
      "original_title": "Knights of the Zodiac",
      "overview":
          "When a headstrong street orphan, Seiya, in search of his abducted sister unwittingly taps into hidden powers, he discovers he might be the only person alive who can protect a reincarnated goddess, sent to watch over humanity. Can he let his past go and embrace his destiny to become a Knight of the Zodiac?",
      "popularity": 3963.447,
      "poster_path": "/qW4crfED8mpNDadSmMdi7ZDzhXF.jpg",
      "release_date": "2023-04-27",
      "title": "Knights of the Zodiac",
      "video": false,
      "vote_average": 6.5,
      "vote_count": 367,
    };

    final result = Movie.fromJson(movieJson);

    expect(result, isInstanceOf<Movie>());
  });
}
