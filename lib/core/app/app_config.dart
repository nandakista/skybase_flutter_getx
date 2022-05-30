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

  static init(Flavors flavors) {
    switch (flavors) {
      case Flavors.PRODUCTION:
        AppConfig.to.setFlavor = Config(
          midtransClientKey: "Mid-client-KSbEOFAHMtQxlEh9",
          midtransSnap: "https://app.midtrans.com/snap/snap.js",
          baseUrl: "https://test.infinids.id/api/",
        );
        break;
      case Flavors.STAGING:
      // TODO: Handle this case.
        break;
      case Flavors.DEVELOPMENT:
        AppSocket().interceptor();
        AppConfig.to.setFlavor = Config(
          midtransClientKey: "SB-Mid-client-jc4soSObl8oZT-m2",
          midtransSnap: "https://app.sandbox.midtrans.com/snap/snap.js",
          baseUrl: "https://test.infinids.id/api/",
        );
        break;
    }
  }
}

class Config {
  Config({
    required this.midtransClientKey,
    required this.midtransSnap,
    required this.baseUrl,
  });
  String midtransClientKey;
  String midtransSnap;
  String baseUrl;
}
