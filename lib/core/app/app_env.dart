// ignore_for_file: constant_identifier_names
import 'package:skybase/app_configuration.dart';
import 'package:skybase/core/app/app_socket.dart';
import 'package:skybase/core/network/api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum Env {
  PRODUCTION,
  STAGING,
  DEVELOPMENT,
}

class AppEnv {
  static late Config config;
  static late Env env;

  static set(Env environment) {
    env = environment;
    switch (environment) {
      case Env.PRODUCTION:
        config = Config(
          baseUrl: AppConfiguration.productionAPI,
          clientToken: AppConfiguration.clientToken,
          tokenType: AppConfiguration.tokenType,
          socketUrl: AppConfiguration.productionSocket,
          midtransClientKey: AppConfiguration.someStagingKey,
        );
        break;
      case Env.STAGING:
        config = Config(
          baseUrl: AppConfiguration.developmentAPI,
          clientToken: AppConfiguration.clientToken,
          tokenType: AppConfiguration.tokenType,
          socketUrl: AppConfiguration.stagingSocket,
          midtransClientKey: AppConfiguration.someStagingKey,
        );
        break;
      case Env.DEVELOPMENT:
        config = Config(
          baseUrl: AppConfiguration.developmentAPI,
          clientToken: AppConfiguration.clientToken,
          tokenType: AppConfiguration.tokenType,
          socketUrl: AppConfiguration.developmentSocket,
          midtransClientKey: AppConfiguration.someStagingKey,
        );
        AppSocket().interceptor();
        break;
    }
  }
}

class Config {
  Config({
    required this.baseUrl,
    required this.clientToken,
    required this.tokenType,
    required this.midtransClientKey,
    required this.socketUrl,
  });
  String baseUrl;
  String clientToken;
  TokenType tokenType;
  String socketUrl;
  String midtransClientKey;
}
