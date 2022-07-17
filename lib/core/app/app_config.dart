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
      // TODO: Handle this case.
        break;
      case Flavors.STAGING:
        // TODO: Handle this case.
        break;
      case Flavors.DEVELOPMENT:
        AppConfig.to.setFlavor = Config(
          midtransClientKey: 'Some Client Key',
          clientToken: 'Some Client Token',
          baseUrl: 'https://api.github.com',
          socketUrl: 'https://address.com',
        );
        AppSocket().interceptor();
        break;
    }
  }
}

class Config {
  Config({
    required this.midtransClientKey,
    required this.clientToken,
    required this.baseUrl,
    required this.socketUrl,
  });
  String midtransClientKey;
  String clientToken;
  String baseUrl;
  String socketUrl;
}
