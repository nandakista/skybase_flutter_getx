import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyPrefs {
  static const isFirstInstall = 'is_first_install';
}

SharedPreferences sharedPreferences = Get.find<SharedPreferences>();
class SharedPreferenceManager {
  static SharedPreferenceManager get to => Get.find<SharedPreferenceManager>();

  bool getIsFirstInstall() {
    final data = sharedPreferences.getBool(KeyPrefs.isFirstInstall);
    return data ?? true;
  }

  Future setIsFirstInstall({required bool value}) async {
    return await sharedPreferences.setBool(KeyPrefs.isFirstInstall, value);
  }

  Future<void> logout() async {
    await sharedPreferences.clear();
    await sharedPreferences.setBool(KeyPrefs.isFirstInstall, false);
  }
}

