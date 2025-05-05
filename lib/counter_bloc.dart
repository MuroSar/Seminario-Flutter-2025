import 'dart:async';

abstract class IBloc{
  void initialize();

  void dispose();
}

abstract class IBlocState{}

class LoadingBlocState extends IBlocState{}

class SuccessBlocState extends IBlocState{
  SuccessBlocState(this.counterValue);

  final int counterValue;
}

class ErrorBlocState extends IBlocState{}

class EmptyBlocState extends IBlocState{}

class CounterBloc extends IBloc{

  final _streamController = StreamController<IBlocState>();

  int _counter = 0;

  get stream => _streamController.stream;

  static const delay = 1;

  Future<void> incrementCounter() async {
    _streamController.sink.add(LoadingBlocState());
    _counter ++;
    await Future.delayed(Duration(seconds: delay));
    _streamController.sink.add(SuccessBlocState(_counter));
  }

  Future<void> throwError() async {
    _streamController.sink.add(LoadingBlocState());
    await Future.delayed(Duration(seconds: delay));
    _streamController.sink.add(ErrorBlocState());
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void initialize() {
    _streamController.sink.add(EmptyBlocState());
  }

}
