import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class LocaleManager {
  static LocaleManager get find => Get.find<LocaleManager>();

  StorageManager storage = StorageManager.find;

  final Map<String, Locale> locales = {
    'English': const Locale('en'),
    'Indonesia': const Locale('id'),
  };

  final fallbackLocale = const Locale('en');

  void showLocaleDialog(BuildContext context) {
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
                    final locale = locales.entries.toList()[index].value;
                    updateLocale(locale);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      locales.entries.toList()[index].key,
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

  void updateLocale(Locale locale) {
    storage.save(StorageKey.CURRENT_LOCALE, locale.languageCode);
    Get.updateLocale(locale);
  }

  Locale get getCurrentLocale {
    String? currentLanguageCode = storage.get(StorageKey.CURRENT_LOCALE);
    if (currentLanguageCode != null) {
      if (currentLanguageCode == 'en') {
        return const Locale('en');
      } else {
        return const Locale('id');
      }
    } else {
      return Get.deviceLocale ?? fallbackLocale;
    }
  }
}
