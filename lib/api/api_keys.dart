import 'package:sarmad/api/environments/environments.dart';
import 'package:sarmad/prefs/pref_manager.dart';

class ApiKeys {
  static late final String baseUrl;
  static late final String baseImageUrl;

  const ApiKeys._();

  static void setEnvironment({required Environment env}) {
    baseUrl = env.envBaseUrl;
    baseImageUrl = env.envBaseImageUrl;
  }

  /// Headers
  static Future<Map<String, String>> getHeaders() async {
    return {
      accept: applicationJson,
      contentType: applicationJson,
      locale: (await PrefManager.getLang() ?? "en")
    };
  }

  /// Keys
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const contentType = "Content-Type";
  static const locale = "locale";

  static final baseApiUrl = '$baseUrl/api/v1';
  static final searchUrl = '$baseApiUrl/integration/focal/screen/individual';
  static final refreshTokenUrl =
      "$baseApiUrl/integration/focal/screen/refresh_token"; //Dummy
}
