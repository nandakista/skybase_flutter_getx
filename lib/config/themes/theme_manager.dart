import 'package:get/get.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ThemeManager extends GetxService {
  static ThemeManager get find => Get.find<ThemeManager>();

  StorageManager storage = StorageManager.find;

  RxBool isDark = false.obs;

  void toDarkMode() => isDark.value = true;

  void toLightMode() => isDark.value = false;

  @override
  void onReady() async {
    isDark.value = await storage.getAwait(StorageKey.IS_DARK_THEME) ?? false;
    super.onReady();
  }

  Future<Rx<bool>> changeTheme() async {
    if (isDark.isTrue) {
      storage.save(StorageKey.IS_DARK_THEME, false);
      isDark.value = false;
    } else {
      storage.save(StorageKey.IS_DARK_THEME, true);
      isDark.value = true;
    }
    return isDark;
  }
}
