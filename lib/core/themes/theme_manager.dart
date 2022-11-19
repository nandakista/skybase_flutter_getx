import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ThemeManager extends GetxService {
  static ThemeManager get find => Get.find<ThemeManager>();

  /// Default value of app theme is Light.
  /// So this variable have default value = false
  RxBool isDark = false.obs;
  toDarkMode() => isDark.value = true;
  toLightMode() => isDark.value = false;

  @override
  void onReady() async {
    isDark.value = await GetStorageManager.find.getAwait(GetStorageKey.darkTheme) ?? false;
    super.onReady();
  }

  /// Default value of theme is Light.
  /// So, if you want use [changeTheme] it will change theme to Dark.
  /// And continuous repeat switching between Dark and Light.
  changeTheme() async {
    if (isDark.isTrue) {
      GetStorageManager.find.save(GetStorageKey.darkTheme, false);
    } else {
      GetStorageManager.find.save(GetStorageKey.darkTheme, true);
    }
    return isDark.toggle();
  }
}