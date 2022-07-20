import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:varcore_flutter_base/core/app/app_config.dart';
import 'package:varcore_flutter_base/core/app/app_socket.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_manager.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_db.dart';
import 'package:varcore_flutter_base/core/database/secure_storage/secure_storage_manager.dart';
import 'package:varcore_flutter_base/core/auth_manager/auth_manager.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';
import 'package:varcore_flutter_base/core/themes/theme_manager.dart';
import 'package:varcore_flutter_base/data/data_sources/local/user/user_dao.dart';

class AppServices extends GetxService {
  static Future<void> init() async {

    /// Database
    /// * [Be Careful] Writing order can affects the algorithm
    await HiveDb.init();
    await GetStorage.init();
    await Get.putAsync(() async => GetStorage());
    Get.put(const FlutterSecureStorage(), permanent: true);

    /// Configuration
    await initializeDateFormatting('id_ID', null);
    Get.lazyPut(() => AppConfig());
    Get.lazyPut(() => AppSocket());
    Get.lazyPut(() => DioClient());
  }

  static Future<void> serviceInit() async {
    // Initialize Apps and checking user auth
    Get.lazyPut(() => GetStorageManager());
    Get.lazyPut(() => SecureStorageManager());
    Get.put(ThemeManager(), permanent: true);
    Get.put(AuthManager(), permanent: true);

    // Dao
    Get.put(UserDao());
  }
}
