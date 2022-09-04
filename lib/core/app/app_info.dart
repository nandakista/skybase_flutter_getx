import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static AppInfo get find => Get.find<AppInfo>();

  late PackageInfo _packageInfo;
  PackageInfo get get => _packageInfo;
  set set(PackageInfo packageInfo) => _packageInfo = packageInfo;

  static setInfo(PackageInfo packageInfo) {
    AppInfo.find.set = packageInfo;
  }
}