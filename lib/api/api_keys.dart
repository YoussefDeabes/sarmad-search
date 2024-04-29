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
  static Future<Map<String, String>> getAuthHeaders() async {
    return {
      accept: applicationJson,
      locale: (await PrefManager.getLang() ?? "en"),
      version: "1",
      platform: 'ios'
    };
  }

  static Future<Map<String, String>> getHeaders() async {
    return {
      authorization: '$keyBearer ${await PrefManager.getToken()}',
      accept: applicationJson,
      locale: (await PrefManager.getLang() ?? "en")
    };
  }

  /// Keys
  static const authorization = "Authorization";
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const contentType = "Content-Type";
  static const locale = "locale";
  static const keyBearer = "Bearer";
  static const migrant = "migrant";
  static const version = "version";
  static const platform = "Platform";
  static const language = "Language";
  static const timeZone = "Timezone";
  static const country = "country";
  static const utcOffset = "UtcOffset";
  static const timezone = "timezone";

  static final baseApiUrl = '$baseUrl/api/v1';
  static final loginUrl = '$baseApiUrl/integration/focal/screen/individual';
  static final refreshTokenUrl =
      "$baseApiUrl/integration/focal/screen/refresh_token"; //Dummy
}
