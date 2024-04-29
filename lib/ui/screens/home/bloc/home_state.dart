part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitialState extends HomeState {}

final class NewSearchState extends HomeState {}

final class DataLoadingState extends HomeState {}

final class DataLoadedState extends HomeState {}

class NetworkError extends HomeState {
  final String message;

  const NetworkError(this.message);
}

class ErrorState extends HomeState {
  final String message;

  const ErrorState(this.message);
}
