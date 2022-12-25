import 'dart:ui';

import 'package:skybase/core/localization/locale_helper.dart';

class LocaleCallback {
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
}