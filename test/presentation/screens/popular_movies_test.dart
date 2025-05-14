import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seminario_flutter/domain/entities/movie.dart';
import 'package:seminario_flutter/domain/usecases/implementations/get_popular_movies_usecase.dart';
import 'package:seminario_flutter/domain/usecases/implementations/get_top_rated_movies_usecase.dart';
import 'package:seminario_flutter/presentation/movies_bloc.dart';
import 'package:seminario_flutter/presentation/screens/popular_movies.dart';

class MockGetPopularMoviesUseCase extends Mock
    implements GetPopularMoviesUseCase {}

class MockGetTopRatedMoviesUseCase extends Mock
    implements GetTopRatedMoviesUseCase {}

void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockGetTopRatedMoviesUseCase mockGetTopRatedMoviesUseCase;
  late MoviesBloc moviesBloc;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockGetTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    moviesBloc = MoviesBloc(
      getPopularMoviesUseCase: mockGetPopularMoviesUseCase,
      getTopRatedMoviesUseCase: mockGetTopRatedMoviesUseCase,
    );
  });

  testWidgets(
    "Tests that when the Popular Movies endpoint is visited with success, a CircularProgressIndicator and a ListView are rendered",
    (WidgetTester tester) async {
      when(
        () => mockGetPopularMoviesUseCase.call(),
      ).thenAnswer((_) async => <Movie>[]);
      await tester.pumpWidget(
        MaterialApp(home: PopularMovies(moviesBloc: moviesBloc)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
    },
  );

    testWidgets(
    "Tests that when an Error is caught, a CircularProgressIndicator and a Text with an error message are rendered",
    (WidgetTester tester) async {
      when(
        () => mockGetPopularMoviesUseCase.call(),
      ).thenAnswer((_) async => throw Error());
      await tester.pumpWidget(
        MaterialApp(home: PopularMovies(moviesBloc: moviesBloc)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.text('Error'), findsOneWidget);
    },
  );
}
