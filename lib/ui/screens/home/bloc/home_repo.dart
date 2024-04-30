import 'package:sarmad/api/api_manager.dart';
import 'package:sarmad/api/errors/error_api_model.dart';
import 'package:sarmad/api/models/search/SearchWrapper.dart';
import 'package:sarmad/api/models/search/search_send_model.dart';
import 'package:sarmad/ui/screens/home/bloc/home_bloc.dart';

abstract class BaseHomeRepo {
  Future<HomeState> searchApi(SearchSendModel model);
}

class HomeRepo extends BaseHomeRepo {
  final ApiManager? apiManager;

  HomeRepo({this.apiManager});

  @override
  Future<HomeState> searchApi(SearchSendModel model) async {
    HomeState? homeState;
    ErrorApiModel? detailsModel;

    await apiManager!.searchApi(model,
          (SearchWrapper searchWrapper) {
        homeState = DataLoadedState(searchWrapper);
      },
          (ErrorApiModel details) {
        detailsModel = details;
        homeState = NetworkError(details.error);
      },
    );
    return homeState!;
  }
}