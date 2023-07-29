import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/app/app_configuration.dart';
import 'config/app/app_env.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/theme_manager.dart';
import 'config/localization/app_translations.dart';
import 'config/localization/locale_helper.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  if (AppEnv.env == Env.DEVELOPMENT) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const App(),
      ),
    );
  } else {
    await initializeDateFormatting('id', null);
    runApp(const App());
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeManager>(
      builder: (theme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfiguration.appName,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: (theme.isDark.isTrue) ? ThemeMode.dark : ThemeMode.light,
        translations: AppTranslation(),
        locale: LocaleHelper().getCurrentLocale(),
        fallbackLocale: LocaleHelper().fallbackLocale,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
      ),
    );
  }
}
