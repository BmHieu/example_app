import '../helper/theme/themes.dart';



class Config {
  String baseUrl;
  Config({
    required this.baseUrl,
  });

  static Environment environment = Environment.local;
  static App app = App();

  static setEnvironment(Environment env) {
    environment = env;
  }

  static String get getBaseUrl {
    switch (environment) {
      case Environment.local:
        return _ConfigMap.localConfig[_ConfigMap.baseUrl];
      case Environment.dev:
        return _ConfigMap.devConfig[_ConfigMap.baseUrl];
      case Environment.staging:
        return _ConfigMap.stagingConfig[_ConfigMap.baseUrl];
      case Environment.prod:
        return _ConfigMap.prodConfig[_ConfigMap.baseUrl];
    }
  }

  static bool get isProd => environment == Environment.prod;
}

class _ConfigMap {
  static const baseUrl = "BASE_URL";

  static Map<String, dynamic> localConfig = {
    baseUrl: "http://10.0.23.184:3000/api",
  };

  static Map<String, dynamic> devConfig = {
    baseUrl: "https://career-app-api-staging.mltechsoft.com",
  };

  static Map<String, dynamic> stagingConfig = {
    baseUrl: 'https://career-app-api-staging.mltechsoft.com',
  };

  static Map<String, dynamic> prodConfig = {
    baseUrl: "https://career-app-api-staging.mltechsoft.com",
  };
}

enum Environment {
  local,
  dev,
  staging,
  prod,
}

class App {
  static late Themes theme;
}