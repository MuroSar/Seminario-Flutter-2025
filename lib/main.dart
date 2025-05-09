import 'package:flutter/material.dart';
import 'package:seminario_flutter/data/datasource/remote/implementations/api_service.dart';
import 'package:seminario_flutter/data/repositories/characters_repository.dart';
import 'package:seminario_flutter/data/repositories/movies_repository.dart';
import 'package:seminario_flutter/domain/repositories/i_characters_repository.dart';
import 'package:seminario_flutter/domain/repositories/i_movies_repository.dart';
import 'package:seminario_flutter/domain/usecases/implementations/get_popular_characters_usecase.dart';
import 'package:seminario_flutter/domain/usecases/implementations/get_popular_movies_usecase.dart';
import 'package:seminario_flutter/domain/usecases/implementations/get_top_rated_movies_usecase.dart';
import 'package:seminario_flutter/domain/usecases/interfaces/i_usecase.dart';
import 'package:seminario_flutter/presentation/characters_bloc.dart';
import 'package:seminario_flutter/presentation/movies_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MoviesBloc _moviesBloc;
  late final CharactersBloc _charactersBloc;

  @override
  void initState() {
    final apiService = ApiService();

    final IMoviesRepository moviesRepository = MoviesRepository(apiService: apiService);

    final ICharactersRepository charactersRepository = CharactersRepository(apiService: apiService);

    final IUseCase getPopularMoviesUseCase = GetPopularMoviesUseCase(moviesRepository);

    final IUseCase getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(moviesRepository);

    final IUseCase getPopularCharacters = GetPopularCharactersUseCase(charactersRepository);

    _moviesBloc = MoviesBloc(getPopularMoviesUseCase: getPopularMoviesUseCase, getTopRatedMoviesUseCase: getTopRatedMoviesUseCase);

    _charactersBloc = CharactersBloc(getCharactersUseCase: getPopularCharacters);

    _moviesBloc.initialize();
    _charactersBloc.initialize();
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    _charactersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                _moviesBloc.getPopularMovies();
              },
              child: Text('Popular'),
            ),
            OutlinedButton(
              onPressed: () {
                _moviesBloc.getTopRatedMovies();
              },
              child: Text('Top Rated'),
            ),
            OutlinedButton(
              onPressed: () {
                _charactersBloc.getPopularCharacters();
              },
              child: Text('Characters'),
            ),
          ],
        ),
      ),
    );
  }
}
