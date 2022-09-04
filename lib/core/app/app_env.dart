// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:skybase/core/app/app_socket.dart';
import 'package:skybase/core/network/api_token_manager.dart';

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
      // TODO: Handle this case.
        break;
      case Env.STAGING:
        // TODO: Handle this case.
        break;
      case Env.DEVELOPMENT:
        AppEnv.find.setEnv = Config(
          midtransClientKey: 'Some Client Key',
          clientToken: 'Some Client Token',
          baseUrl: 'https://api.github.com',
          socketUrl: 'https://address.com',
          tokenType: TokenType.ACCESS_TOKEN,
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
  String socketUrl;
  TokenType tokenType;
  String midtransClientKey;
  String clientToken;
}
