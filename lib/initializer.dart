import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skybase/core/app/app_socket.dart';
import 'package:skybase/core/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/database/hive/hive_db.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
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
    Get.lazyPut(() => AppSocket());
    Get.lazyPut(() => DioClient());
  }

  static Future<void> _initService() async {
    Get.lazyPut(() => GetStorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.put(ThemeManager());

    Get.put(AuthManager());
    // TODO : Uncomment code below if want to activate flutter_downloader
    // await DownloadManager.initDownloader();
  }
}
