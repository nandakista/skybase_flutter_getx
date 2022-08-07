import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skybase/core/app/app_config.dart';
import 'package:skybase/initializer.dart';
import 'package:skybase/core/helper/general_function.dart';
import 'package:skybase/core/localization/app_translations.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/themes/app_theme.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/ui/routes/app_routes.dart';
import 'package:skybase/ui/views/utils/utils_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Initializer.initConfig();
  await Initializer.initService();
  AppConfig.set(Env.DEVELOPMENT);
  AppStatusBar.set(brightness: Brightness.light);
  AppOrientation.lock(DeviceOrientation.portraitUp);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ThemeManager>(
      builder: (controller) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Skybase Flutter Getx",
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode:
            (controller.isDark.isTrue) ? ThemeMode.dark : ThemeMode.light,
        translations: AppTranslation(),
        locale: LocaleHelper().getCurrentLocale(),
        fallbackLocale: LocaleHelper().fallbackLocale,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
        // home: UtilsView(),
      ),
    );
  }
}
