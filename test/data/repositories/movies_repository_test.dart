import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seminario_flutter/data/datasource/local/implementations/sqflite_database.dart';
import 'package:seminario_flutter/data/datasource/remote/implementations/api_service.dart';
import 'package:seminario_flutter/data/models/movie_response.dart';
import 'package:seminario_flutter/data/repositories/movies_repository.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';

class MockApiService extends Mock implements ApiService {}

class MockDatabaseService extends Mock implements SqfliteDatabase {}

class MockConnectivityPlugin extends Mock implements Connectivity {}

void main() {
  late MockApiService mockApiService;
  late MockDatabaseService mockDatabaseService;
  late MockConnectivityPlugin mockConnectivityPlugin;

  setUp(() {
    mockApiService = MockApiService();
    mockDatabaseService = MockDatabaseService();
    mockConnectivityPlugin = MockConnectivityPlugin();
  });

  test(
    "Should return a List of Movies when getPopularMovies is called and completed, and the internet connection is enabled",
    () async {
      when(() => mockApiService.getPopularMovies()).thenAnswer(
        (_) async => Future.value(
          MovieResponse(results: [], page: 1, totalPages: 1, totalResult: 1),
        ),
      );
      when(
        () => mockConnectivityPlugin.checkConnectivity(),
      ).thenAnswer((_) async => Future.value([ConnectivityResult.wifi]));
      final MoviesRepository moviesRepository = MoviesRepository(
        apiService: mockApiService,
        databaseService: mockDatabaseService,
        connectivityPlugin: mockConnectivityPlugin,
      );
      final result = await moviesRepository.getPopularMovies();
      expect(result, isA<List<Movie>>());
    },
  );

  test(
    "Should throw an Exception when getPopularMovies is called and ApiService throws error",
    () async {
      when(
        () => mockApiService.getPopularMovies(),
      ).thenAnswer((_) => throw (Error()));
      final MoviesRepository moviesRepository = MoviesRepository(
        apiService: mockApiService,
        databaseService: mockDatabaseService,
      );

      expect(
        () => moviesRepository.getPopularMovies(),
        throwsA(isA<Exception>()),
      );
    },
  );
}
