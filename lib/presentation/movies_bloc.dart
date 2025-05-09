import 'dart:async';

import 'package:seminario_flutter/domain/entities/movie.dart';
import 'package:seminario_flutter/domain/usecases/interfaces/i_usecase.dart';
import 'package:seminario_flutter/presentation/bloc_state.dart';

import '../core/bloc/i_bloc.dart';

class MoviesBloc implements IBloc {
  MoviesBloc({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
  });

  final IUseCase getPopularMoviesUseCase;
  final IUseCase getTopRatedMoviesUseCase;

  final _streamController = StreamController<BlocState>.broadcast();

  Stream<BlocState> get moviesStream => _streamController.stream;

  void getPopularMovies() async {
    _streamController.sink.add(LoadingBlocState());

    try {
      final List<Movie> movieList = await getPopularMoviesUseCase.call();
      _streamController.sink.add(SuccessBlocState<List<Movie>>(movieList));
    } catch (error) {
      print('$error');
      _streamController.sink.add(ErrorBlocState());
    }
  }

  void getTopRatedMovies() async {
    _streamController.sink.add(LoadingBlocState());

    try {
      final List<Movie> movieList = await getTopRatedMoviesUseCase.call();
      _streamController.sink.add(SuccessBlocState<List<Movie>>(movieList));
    } catch (error) {
      print('$error');
      _streamController.sink.add(ErrorBlocState());
    }
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void initialize() {
    _streamController.sink.add(LoadingBlocState());
    _streamController.sink.add(EmptyBlocState());
  }
}
