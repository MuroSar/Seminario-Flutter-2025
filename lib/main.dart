import 'package:flutter/material.dart';
import 'package:seminario_flutter/data/datasource/local/implementations/sqflite_database.dart';
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
import 'package:seminario_flutter/presentation/screens/popular_characters.dart';
import 'package:seminario_flutter/presentation/screens/popular_movies.dart';
import 'package:seminario_flutter/presentation/screens/top_rated_movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  final databaseService = await SqfliteDatabase.getInstance();

  final IMoviesRepository moviesRepository = MoviesRepository(
    apiService: apiService,
    databaseService: databaseService,
  );

  final ICharactersRepository charactersRepository = CharactersRepository(
    apiService: apiService,
    databaseService: databaseService,
  );

  final IUseCase getPopularMoviesUseCase = GetPopularMoviesUseCase(
    moviesRepository,
  );

  final IUseCase getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(
    moviesRepository,
  );

  final IUseCase getPopularCharacters = GetPopularCharactersUseCase(
    charactersRepository,
  );

  final movieBloc = MoviesBloc(
    getPopularMoviesUseCase: getPopularMoviesUseCase,
    getTopRatedMoviesUseCase: getTopRatedMoviesUseCase,
  );

  final characterBloc = CharactersBloc(
    getCharactersUseCase: getPopularCharacters,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/popular-movies':
            (BuildContext context) => PopularMovies(moviesBloc: movieBloc),
        '/top-rated-movies':
            (BuildContext context) => TopRatedMovies(moviesBloc: movieBloc),
        '/popular-characters':
            (BuildContext context) =>
                PopularCharacters(charactersBloc: characterBloc),
      },
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Movies app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/popular-movies');
              },
              child: Text('Popular'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/top-rated-movies');
              },
              child: Text('Top Rated'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/popular-characters');
              },
              child: Text('Characters'),
            ),
          ],
        ),
      ),
    );
  }
}
