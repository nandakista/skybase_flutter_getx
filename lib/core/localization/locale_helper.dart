import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class LocaleHelper {
  final List<Map<String, dynamic>> locales = [
    {'name': 'English', 'locale': const Locale('en')},
    {'name': 'Indonesia', 'locale': const Locale('id')}
  ];

  final fallbackLocale = const Locale('en');

  static T builder<T>({
    required T enCallback,
    required T idCallback,
  }) {
    if (LocaleHelper().getCurrentLocale() == const Locale('en')) {
      return enCallback;
    } else {
      return idCallback;
    }
  }

  showLocaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SkyDialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'txt_choose_language'.tr,
                style: AppStyle.subtitle2.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locales.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.5),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    updateLocale(context, locales[index]['locale'],
                        locales[index]['name'].toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      locales[index]['name'].toString(),
                      style: AppStyle.body1,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  updateLocale(BuildContext context, Locale locale, String name) {
    saveLocaleToCache(name);
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }

  saveLocaleToCache(String name) {
    if (name == "English") {
      GetStorageManager.find.save(GetStorageKey.currentLocale, "en");
    } else {
      GetStorageManager.find.save(GetStorageKey.currentLocale, "in");
    }
  }

  Locale getCurrentLocale() {
    var currentLocale = GetStorageManager.find.get(GetStorageKey.currentLocale);
    if (currentLocale != null) {
      if (currentLocale == "en") {
        return const Locale('en');
      } else {
        return const Locale('id');
      }
    } else {
      GetStorageManager.find.save(GetStorageKey.currentLocale, "en");
      return const Locale('en');
    }
  }
}
