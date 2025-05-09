abstract class BlocState {}

class LoadingBlocState extends BlocState {}

class SuccessBlocState<T> extends BlocState {
  SuccessBlocState(this.result);

  final T result;
}

class ErrorBlocState extends BlocState {}

class EmptyBlocState extends BlocState {}
