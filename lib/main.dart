import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_config.dart';
import 'package:varcore_flutter_base/initializer.dart';
import 'package:varcore_flutter_base/core/helper/general_function.dart';
import 'package:varcore_flutter_base/core/localization/app_translations.dart';
import 'package:varcore_flutter_base/core/localization/locale_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_theme.dart';
import 'package:varcore_flutter_base/core/themes/theme_manager.dart';
import 'package:varcore_flutter_base/ui/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Initializer.initConfig();
  await Initializer.initService();
  AppConfig.set(Flavors.DEVELOPMENT);
  AppStatusBar.set(brightness: Brightness.light);
  AppOrientation.lock(DeviceOrientation.portraitUp);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ThemeManager>(
      builder: (controller) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Varcore Base Code",
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode:
            (controller.isDark.isTrue) ? ThemeMode.dark : ThemeMode.light,
        translations: AppTranslation(),
        locale: LocaleHelper().getCurrentLocale(),
        fallbackLocale: LocaleHelper().fallbackLocale,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
      ),
    );
  }
}
