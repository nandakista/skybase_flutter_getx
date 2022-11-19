import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AppInfo extends GetxService {
  static AppInfo get find => Get.find<AppInfo>();

  late PackageInfo _packageInfo;
  PackageInfo get get => _packageInfo;

  @override
  void onInit() async {
    _packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }
}