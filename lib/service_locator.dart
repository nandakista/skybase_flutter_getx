import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/database/hive/hive_db.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/config/network/api_config.dart';
import 'package:skybase/config/themes/app_theme.dart';
import 'package:skybase/config/themes/theme_manager.dart';

import 'core/app/app_info.dart';
import 'core/database/get_storage/get_storage_key.dart';
import 'core/helper/http_overrides.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ServiceLocator {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    HttpOverrides.global = MyHttpOverrides();
    await _initConfig();
    await _initService();
    AppTheme.setStatusBar(brightness: Brightness.light);
    AppInfo.setInfo(await PackageInfo.fromPlatform());
  }

  static Future<void> _initConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Database
    // * [Be Careful] Writing order can affects the algorithm
    await HiveDb.init();
    if (Platform.isIOS) {
      final dir = await getLibraryDirectory();
      await Get.putAsync(
        () async => GetStorage(GetStorageKey.STORAGE_NAME, dir.path),
      );
      await GetStorage(GetStorageKey.STORAGE_NAME, dir.path).initStorage;
    } else {
      await Get.putAsync(() async => GetStorage());
      await GetStorage(GetStorageKey.STORAGE_NAME).initStorage;
    }
    Get.putAsync(() async => const FlutterSecureStorage());

    // Configuration
    Get.lazyPut(() => DioClient());
  }

  static Future<void> _initService() async {
    Get.lazyPut(() => GetStorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.put(ThemeManager());

    Get.put(AuthManager());
  }
}
