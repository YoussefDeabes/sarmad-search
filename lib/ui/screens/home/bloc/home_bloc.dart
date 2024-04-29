import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(_onInitialEventSelected);
    on<NewSearchEvent>(_onNewSearchSelected);
    on<SearchButtonEvent>(_onSearchSelected);
  }

  _onInitialEventSelected(HomeInitialEvent event, emit) async {
    emit(HomeInitialState());
  }

  _onNewSearchSelected(NewSearchEvent event, emit) async {
    emit(NewSearchState());
  }

  _onSearchSelected(SearchButtonEvent event, emit) async {
    emit(DataLoadingState());
    emit(DataLoadedState());
  }
}
