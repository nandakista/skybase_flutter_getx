import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/app/app_info.dart';
import 'package:skybase/core/app/app_socket.dart';
import 'package:skybase/core/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/database/hive/hive_db.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/download_manager/download_manager.dart';
import 'package:skybase/core/helper/general_function.dart';
import 'package:skybase/core/network/api_config.dart';
import 'package:skybase/core/themes/app_theme.dart';
import 'package:skybase/core/themes/theme_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class Initializer {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    HttpOverrides.global = MyHttpOverrides();
    await _initConfig();
    await _initService();
    AppTheme.setStatusBar(brightness: Brightness.light);
  }

  static Future<void> _initConfig() async {
    // Database
    // * [Be Careful] Writing order can affects the algorithm
    await HiveDb.init();
    await GetStorage.init();
    await Get.putAsync(() async => GetStorage());
    Get.putAsync(() async => const FlutterSecureStorage());

    // Configuration
    // --- Package Info
    Get.lazyPut(() => AppInfo());
    // --- App Config
    Get.lazyPut(() => AppEnv());
    // --- Web Socket
    Get.lazyPut(() => AppSocket());
    // --- Request Client
    Get.lazyPut(() => DioClient());
  }

  static Future<void> _initService() async {
    // Initialize Apps and checking user auth
    Get.lazyPut(() => GetStorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.put(ThemeManager());

    // Checking user auth
    Get.put(AuthManager());
    await DownloadManager().initDownloader();
  }
}
