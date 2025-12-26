import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skybase/core/helper/orientation_helper.dart';
import 'package:skybase/core/localization/locale_manager.dart';

import 'config/auth_manager/auth_manager.dart';
import 'config/network/api_config.dart';
import 'config/themes/theme_manager.dart';
import 'config/app/app_info.dart';
import 'core/database/storage/storage_key.dart';
import 'core/database/storage/storage_manager.dart';
import 'core/database/secure_storage/secure_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ServiceLocator {
  static Future<void> init() async {
    /// Hide debugPrint on Release
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};

    /// Lock app orientation
    AppOrientation.lock([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await AppInfo.init();

    /// Configs
    await _initStorage();
    Get.put(const FlutterSecureStorage());
    Get.lazyPut(() => DioClient());

    /// Managers
    Get.lazyPut(() => StorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.lazyPut(() => ThemeManager());
    Get.lazyPut(() => LocaleManager());
    Get.put(AuthManager());
  }

  static Future<void> _initStorage() async {
    late final GetStorage storage;
    if (Platform.isIOS) {
      final dir = await getLibraryDirectory();
      storage = GetStorage(StorageKey.STORAGE_NAME, dir.path);
    } else {
      storage = GetStorage(StorageKey.STORAGE_NAME);
    }
    await storage.initStorage;
    Get.put(storage);
  }
}
