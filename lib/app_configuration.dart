import 'package:skybase/core/app/app_info.dart';
import 'package:skybase/core/network/api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AppConfiguration {
  //-- Main Configuration
  static const clientToken = 'Some Client Token';
  static const tokenType = TokenType.ACCESS_TOKEN;

  //-- Production
  static const productionAPI = 'https://api.github.com';
  static const productionSocket = 'production socket url';
  static const someProductionKey = 'Some Key';

  //-- Staging
  static const stagingAPI = 'https://api.github.com';
  static const stagingSocket = 'staging socket url';
  static const someStagingKey = 'Some Key';

  //-- Development
  static const developmentAPI = 'https://api.github.com';
  static const developmentSocket = 'development socket url';
  static const someDevKey = 'Some Key';

  //-- App Info
  static String appName = 'Skybase';
  static String appTag = 'Flutter Getx';
  static String appVersion = AppInfo.packageInfo.version;
  static String buildNumber = AppInfo.packageInfo.buildNumber;
  static String packageName = AppInfo.packageInfo.packageName;
}