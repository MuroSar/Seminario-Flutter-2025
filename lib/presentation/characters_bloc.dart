import 'dart:async';

import 'package:seminario_flutter/core/bloc/i_bloc.dart';
import 'package:seminario_flutter/domain/entities/character.dart';
import 'package:seminario_flutter/domain/usecases/interfaces/i_usecase.dart';
import 'package:seminario_flutter/presentation/bloc_state.dart';

class CharactersBloc implements IBloc {
  CharactersBloc({required this.getCharactersUseCase});

  final IUseCase getCharactersUseCase;

  final _streamController = StreamController<BlocState>.broadcast();

  Stream<BlocState> get charactersStream => _streamController.stream;

  void getPopularCharacters() async {
    _streamController.sink.add(LoadingBlocState());

    try {
      final List<Character> charactersList = await getCharactersUseCase.call();

      _streamController.sink.add(
        SuccessBlocState<List<Character>>(charactersList),
      );
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
