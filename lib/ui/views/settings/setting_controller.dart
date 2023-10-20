import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/localization/locale_manager.dart';

class SettingController extends GetxController {
  final languageCode = Rxn<String>();

  @override
  void onInit() {
    languageCode.value = LocaleManager.find.getCurrentLocale().languageCode;
    super.onInit();
  }

  void onUpdateLocale(String languageCode) {
    this.languageCode.value = languageCode;
    StorageManager.find.save(StorageKey.CURRENT_LOCALE, languageCode);
    Get.updateLocale(Locale(languageCode));
  }

  void onLogout() async {
    LoadingDialog.show();
    AuthManager.find.logout();
  }
}
