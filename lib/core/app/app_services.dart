import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varcore_flutter_base/core/app/app_config.dart';
import 'package:varcore_flutter_base/core/app/app_socket.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_manager.dart';
import 'package:varcore_flutter_base/core/database/secure_storage/secure_storage_manager.dart';
import 'package:varcore_flutter_base/core/database/shared_preferences/shared_preference_manager.dart';
import 'package:varcore_flutter_base/core/auth_manager/auth_manager.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';

class AppServices extends GetxService {
  static Future<void> init() async {
    /// Database
    /// * [Be Careful] Writing order affects
    await Get.putAsync(() async => GetStorage());
    await Get.putAsync(() async => await SharedPreferences.getInstance());
    Get.put(GetStorageManager(), permanent: true);
    Get.put(const FlutterSecureStorage(), permanent: true);

    Get.lazyPut(() => AppConfig());
    Get.lazyPut(() => AppSocket());
    Get.lazyPut(() => DioClient());
    Get.lazyPut(() => SecureStorageManager());
    Get.lazyPut(() => SharedPreferenceManager());

    /// Initialize Apps and checking user auth
    Get.put(AuthManager());
  }
}
