import 'package:sarmad/api/environments/environment.dart';

class ProdEnv implements Environment {
  const ProdEnv();

  @override
  String get envBaseUrl => "https://develop.sarmad.sa";
  @override
  String get envBaseImageUrl => "https://develop.sarmad.sa";

}
