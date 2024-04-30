part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class NewSearchEvent extends HomeEvent {}

class SearchButtonEvent extends HomeEvent {
  final SearchSendModel model;
  SearchButtonEvent(this.model);
}
