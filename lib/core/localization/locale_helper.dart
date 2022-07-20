import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_key.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_manager.dart';
import 'package:varcore_flutter_base/core/localization/language_const.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

class LocaleHelper {
  final List<Map<String, dynamic>> locales = [
    {'name': 'English', 'locale': const Locale('en')},
    {'name': 'Indonesia', 'locale': const Locale('id')}
  ];

  final fallbackLocale = const Locale('en');

  showLocaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(International.chooseLanguage.tr, style: const TextStyle(color: AppColors.primary),),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      updateLocale(context, locales[index]['locale'],
                          locales[index]['name'].toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(locales[index]['name'].toString()),
                    )),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: locales.length),
          ),
        );
      },
    );
  }

  updateLocale(BuildContext context, Locale locale, String name) {
    saveLanguagesToCache(name);
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }

  saveLanguagesToCache(String name) {
    if (name == "English") {
      GetStorageManager.to.save(GetStorageKey.CURRENT_LOCALE, "en");
    } else {
      GetStorageManager.to.save(GetStorageKey.CURRENT_LOCALE, "in");
    }
  }

  Locale getCurrentLocale() {
    var currentLocale = GetStorageManager.to.get(GetStorageKey.CURRENT_LOCALE);
    if (currentLocale != null) {
      if (currentLocale == "en") {
        return const Locale('en');
      } else {
        return const Locale('id');
      }
    } else {
      return const Locale('en');
    }
  }
}
