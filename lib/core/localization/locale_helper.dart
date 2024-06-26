import 'dart:ui';

import 'locale_manager.dart';

class LocaleHelper {
  static T builder<T>({
    required T en,
    required T id,
  }) {
    if (LocaleManager.find.getCurrentLocale == const Locale('en')) {
      return en;
    } else {
      return id;
    }
  }
}