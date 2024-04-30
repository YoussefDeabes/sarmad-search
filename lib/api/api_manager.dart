import 'package:dio/dio.dart';
import 'package:sarmad/api/api_keys.dart';
import 'package:sarmad/api/base/base_api_manager.dart';
import 'package:sarmad/api/errors/error_api_model.dart';
import 'package:sarmad/api/models/search/SearchWrapper.dart';
import 'package:sarmad/api/models/search/search_send_model.dart';

class ApiManager {
  final DioApiManager dioApiManager;

  ApiManager(this.dioApiManager);

  Future<void> searchApi(SearchSendModel model,void Function(SearchWrapper) success,
      void Function(ErrorApiModel) fail) async {
    await dioApiManager.dio
        .post(ApiKeys.searchUrl,data: model.toMap(),
            options: Options(headers: await ApiKeys.getHeaders()))
        .then((response) {
      Map<String, dynamic> extractedData =
          response.data as Map<String, dynamic>;
      SearchWrapper wrapper = SearchWrapper.fromJson(extractedData);

      if (response.statusCode == 200) {
        print("Status code: " + response.statusCode.toString() );
        success(wrapper);
      } else {
        ErrorApiModel errorApiModel = ErrorApiModel(
          status: response.statusCode!,
          isMessageLocalizationKey: false,
          error: response.statusMessage ?? extractedData["error"],
        );
        fail(errorApiModel);
      }
    }).onError((DioError error, stackTrace) {

      fail(ErrorApiModel.fromDioError(error));
    }).catchError((onError) {
      fail(ErrorApiModel.identifyError());
    });
  }
}
