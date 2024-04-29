import 'package:sarmad/api/environments/environment.dart';

class DevEnv implements Environment {
  const DevEnv();

  /// Dev:
  @override
  String get envBaseUrl => "https://develop.sarmad.sa";
  @override
  String get envBaseImageUrl => "https://develop.sarmad.sa";

}
