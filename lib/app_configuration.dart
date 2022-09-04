import 'package:skybase/core/app/app_info.dart';
import 'package:skybase/core/network/api_token_manager.dart';

class AppConfiguration {
  //-- Main Configuration
  static const clientToken = 'Some Client Token';
  static const tokenType = TokenType.ACCESS_TOKEN;

  //-- Production
  static const productionAPI = 'https://api.github.com';
  static const productionSocket = 'https://api.github.com';
  static const midtransProductionKey = 'Some Key';

  //-- Staging
  static const stagingAPI = 'https://api.github.com';
  static const stagingSocket = 'https://api.github.com';
  static const midtransStagingKey = 'Some Key';

  //-- Development
  static const developmentAPI = 'https://api.github.com';
  static const developmentSocket = 'https://api.github.com';
  static const midtransDevKey = 'Some Key';

  //-- App Info
  static String appName = 'PSC119';
  static String appTag = 'Kabupaten Lampung Timur';
  static String appVersion = AppInfo.find.get.version;
  static String buildNumber = AppInfo.find.get.buildNumber;
  static String packageName = AppInfo.find.get.packageName;
}