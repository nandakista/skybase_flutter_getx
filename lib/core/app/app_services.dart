import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varcore_flutter_base/core/app/app_config.dart';
import 'package:varcore_flutter_base/core/app/app_socket.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage.dart';
import 'package:varcore_flutter_base/core/database/get_storage/storage_helper.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';

class AppServices extends GetxService {
  static Future<void> init() async {
    await Get.putAsync<SharedPreferences>(
            () async => await SharedPreferences.getInstance(),
        permanent: true);
    await Get.putAsync<GetStorage>(() async => GetStorage());
    Get.put(GetStorageHelper(), permanent: true);
    Get.lazyPut(() => AppConfig());
    Get.lazyPut(() => AppSocket());
    Get.lazyPut(() => DioClient());

    Get.put(LocalStorage(), permanent: true);

    // await Get.putAsync<FlutterSecureStorage>(() async {
    //   return FlutterSecureStorage();
    // });
  }
}
