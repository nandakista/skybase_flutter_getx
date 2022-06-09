import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferences prefs = Get.find<SharedPreferences>();
class KeyPrefs {
  static const firstOpen = 'onboarding';
}

class SPrefs {
  static Future<void> logout() async {
    await prefs.clear();
    await prefs.setBool(KeyPrefs.firstOpen, false);
  }
}

