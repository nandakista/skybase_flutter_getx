import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ThemeManager extends GetxService {
  static ThemeManager get find => Get.find<ThemeManager>();

  RxBool isDark = false.obs;
  void toDarkMode() => isDark.value = true;
  void toLightMode() => isDark.value = false;

  @override
  void onReady() async {
    isDark.value = await GetStorageManager.find.getAwait(GetStorageKey.darkTheme) ?? false;
    super.onReady();
  }

  Future<Rx<bool>> changeTheme() async {
    if (isDark.isTrue) {
      GetStorageManager.find.save(GetStorageKey.darkTheme, false);
    } else {
      GetStorageManager.find.save(GetStorageKey.darkTheme, true);
    }
    return isDark.toggle();
  }
}