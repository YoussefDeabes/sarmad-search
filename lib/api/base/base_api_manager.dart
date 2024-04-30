import 'package:dio/dio.dart';
import 'package:sarmad/api/api_keys.dart';
import 'package:sarmad/prefs/pref_manager.dart';
import 'package:sarmad/util/general.dart';

class DioApiManager {
  final String defaultLanguage = "ar";
  //  dio instance to request token
  DioApiManager(PrefManager preferencesManager);

  Dio get dio {
    return DioOptions.dioInstance(options)
      ..interceptors.clear()
      ..interceptors.addAll(
        [
          _queuedInterceptorsWrapper,
          if (isDebugMode()) ...[
            LogInterceptor(responseBody: true, requestBody: true, error: true)
          ],
        ],
      );
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapper {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) async {
        String language =
            await PrefManager.getLang() ?? defaultLanguage;
        if (request.headers[ApiKeys.locale] != language) {
          request.headers[ApiKeys.locale] = language;
        }

        return handler.next(request);
      },
    );
  }

  DioOptions get options => DioOptions();
}

class DioOptions extends BaseOptions {
  @override
  Map<String, dynamic> get headers {
    Map<String, dynamic> header = {};

    header.putIfAbsent(ApiKeys.accept, () => ApiKeys.applicationJson);

    return header;
  }

  @override
  String get baseUrl => ApiKeys.baseApiUrl;

  static Dio? dio;

  static Dio dioInstance(BaseOptions options) {
    dio ??= Dio(options);

    return dio!;
  }
}