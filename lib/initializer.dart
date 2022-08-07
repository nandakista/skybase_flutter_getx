import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skybase/core/app/app_config.dart';
import 'package:skybase/core/app/app_socket.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/database/hive/hive_db.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/auth_manager/auth_manager.dart';
import 'package:skybase/core/network/api_config.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/data/data_sources/local/user/user_dao.dart';

class Initializer extends GetxService {
  static Future<void> initConfig() async {

    // Database
    // * [Be Careful] Writing order can affects the algorithm
    await HiveDb.init();
    await GetStorage.init();
    await Get.putAsync(() async => GetStorage());
    Get.put(const FlutterSecureStorage(), permanent: true);

    // Configuration
    // ---Locale
    await initializeDateFormatting('id_ID', null);
    // --- App Config
    Get.lazyPut(() => AppConfig());
    // --- Web Socket
    Get.lazyPut(() => AppSocket());
    // --- Request Client
    Get.lazyPut(() => DioClient());
  }

  static Future<void> initService() async {
    // Initialize Apps and checking user auth
    Get.lazyPut(() => GetStorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.put(ThemeManager(), permanent: true);

    // Checking user auth
    Get.put(AuthManager(), permanent: true);

    // Dao
    Get.put(UserDao());
  }
}
