import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/config/localization/locale_helper.dart';

class SettingController extends GetxController {
  final language = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    Locale currentLocale = LocaleHelper().getCurrentLocale();
    if (currentLocale == const Locale('en')) {
      language.value = {
        'name': 'English',
        'locale': 'en',
      };
    } else {
      language.value = {
        'name': 'Indonesia',
        'locale': 'id',
      };
    }
    super.onInit();
  }

  void onUpdateLocale(String value) {
    Map<String, dynamic> lang = jsonDecode(value.toString());
    language.value = lang;
    if (lang['name'].toString() == "English") {
      GetStorageManager.find.save(GetStorageKey.CURRENT_LOCALE, "en");
    } else {
      GetStorageManager.find.save(GetStorageKey.CURRENT_LOCALE, "in");
    }
    Get.updateLocale(Locale(lang['locale']));
  }

  void onLogout() async {
    LoadingDialog.show();
    AuthManager.find.logout();
  }
}
