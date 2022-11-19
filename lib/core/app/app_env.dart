// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
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
  static AppEnv get find => Get.find<AppEnv>();

  late Config appConfig;
  Config get get => appConfig;
  set setEnv(Config config) => appConfig = config;

  static set(Env env) {
    switch (env) {
      case Env.PRODUCTION:
        AppEnv.find.setEnv = Config(
          baseUrl: AppConfiguration.productionAPI,
          clientToken: AppConfiguration.clientToken,
          tokenType: AppConfiguration.tokenType,
          socketUrl: AppConfiguration.productionSocket,
          midtransClientKey: AppConfiguration.someStagingKey,
        );
        break;
      case Env.STAGING:
        AppEnv.find.setEnv = Config(
          baseUrl: AppConfiguration.developmentAPI,
          clientToken: AppConfiguration.clientToken,
          tokenType: AppConfiguration.tokenType,
          socketUrl: AppConfiguration.stagingSocket,
          midtransClientKey: AppConfiguration.someStagingKey,
        );
        break;
      case Env.DEVELOPMENT:
        AppEnv.find.setEnv = Config(
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
