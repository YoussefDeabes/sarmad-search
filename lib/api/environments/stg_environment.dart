import 'package:sarmad/api/environments/environment.dart';

class StagingEnv implements Environment {
  const StagingEnv();

  /// Staging:
  @override
  String get envBaseUrl => "https://develop.sarmad.sa";
  @override
  String get envBaseImageUrl => "https://develop.sarmad.sa";

}
