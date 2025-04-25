import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skybase/ui/views/404_500/unknown_page.dart';

import 'config/environment/app_env.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/theme_manager.dart';
import 'core/localization/app_translations.dart';
import 'core/localization/locale_manager.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';
import 'ui/views/404_500/crash_error_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  if (AppEnv.env.isDev) {
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
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeManager>(
      builder: (theme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skybase Getx',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: (theme.isDark.isTrue) ? ThemeMode.dark : ThemeMode.light,
        translations: AppTranslation(),
        locale: LocaleManager.find.getCurrentLocale,
        fallbackLocale: LocaleManager.find.fallbackLocale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: LocaleManager.find.locales.values,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
        unknownRoute: unknownPage,
        builder: (BuildContext context, child) {
          ErrorWidget.builder = (FlutterErrorDetails error) {
            return CrashErrorView(errorDetails: error);
          };
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}
