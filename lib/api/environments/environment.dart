import 'package:sarmad/api/api_keys.dart';
import 'package:sarmad/api/environments/environments.dart';

enum EnvType {
  prod(environmentName: "production" ),
  stg(environmentName: "staging"),
  dev(environmentName: "dev");

  const EnvType({required this.environmentName});

  final String environmentName;
}

abstract class Environment {
  static late EnvType _envType;

  static EnvType get envType => _envType;
  final String envBaseUrl;
  final String envBaseImageUrl;



  const Environment(
    this.envBaseUrl,
    this.envBaseImageUrl,
  );

  static void init({required EnvType envType}) {
    _envType = envType;
    Environment env;
    switch (envType) {
      case EnvType.prod:
        env = const ProdEnv();
        break;
      case EnvType.stg:
        env = const StagingEnv();
        break;
      case EnvType.dev:
        env = const DevEnv();
        break;
    }
    ApiKeys.setEnvironment(env: env);
  }
}
