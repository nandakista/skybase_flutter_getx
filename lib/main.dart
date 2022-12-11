import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/app/app_info.dart';
import 'package:skybase/initializer.dart';
import 'package:skybase/core/localization/app_translations.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/themes/app_theme.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/ui/routes/app_routes.dart';

import 'app_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();
  AppEnv.set(Env.DEVELOPMENT);
  AppInfo.setInfo(await PackageInfo.fromPlatform());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ThemeManager>(
      builder: (ctr) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfiguration.appName,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: (ctr.isDark.isTrue) ? ThemeMode.dark : ThemeMode.light,
        translations: AppTranslation(),
        locale: LocaleHelper().getCurrentLocale(),
        fallbackLocale: LocaleHelper().fallbackLocale,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
      ),
    );
  }
}
