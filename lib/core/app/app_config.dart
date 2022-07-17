// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_socket.dart';

enum Flavors {
  PRODUCTION,
  STAGING,
  DEVELOPMENT,
}

class AppConfig {
  static AppConfig get to => Get.find<AppConfig>();

  late Config appConfig;
  Config get get => appConfig;
  set setFlavor(Config config) => appConfig = config;

  static set(Flavors flavors) {
    switch (flavors) {
      case Flavors.PRODUCTION:
        AppConfig.to.setFlavor = Config(
          midtransClientKey: 'Some Client Key',
          accessToken: 'Some Token',
          baseUrl: 'https://google.com',
          socketUrl: 'https://address.com',
        );
        break;
      case Flavors.STAGING:
        // TODO: Handle this case.
        break;
      case Flavors.DEVELOPMENT:
        AppSocket().interceptor();
        AppConfig.to.setFlavor = Config(
          midtransClientKey: 'Some Client Key',
          accessToken: 'Some Token',
          baseUrl: 'https://google.com',
          socketUrl: 'https://address.com',
        );
        break;
    }
  }
}

class Config {
  Config({
    required this.midtransClientKey,
    required this.accessToken,
    required this.baseUrl,
    required this.socketUrl,
  });
  String midtransClientKey;
  String accessToken;
  String baseUrl;
  String socketUrl;
}
