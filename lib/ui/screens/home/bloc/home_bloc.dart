import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sarmad/api/models/search/SearchWrapper.dart';
import 'package:sarmad/api/models/search/search_send_model.dart';
import 'package:sarmad/ui/screens/home/bloc/home_repo.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BaseHomeRepo _baseRepo;
  HomeBloc(this._baseRepo) : super(HomeInitialState()){
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
    HomeState state = await _baseRepo.searchApi(event.model);
    emit(state);
  }
}
