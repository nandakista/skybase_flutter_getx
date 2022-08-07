import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skybase/core/themes/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.materialPrimary,
  primarySwatch: AppColors.materialPrimary,
  indicatorColor: AppColors.accent,
  fontFamily: "Poppins",
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      statusBarColor: AppColors.primary,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.materialPrimary,
  primarySwatch: AppColors.materialPrimary,
  indicatorColor: AppColors.accent,
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      statusBarColor: AppColors.primary,
    ),
  ),
);

extension DarkMode on BuildContext {
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

class AppStatusBar {
  static set({
    required Brightness brightness,
    Color color = AppColors.primary,
  }) {
    return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarColor: color,
      ),
    );
  }
}

class AppOrientation {
  static lock(DeviceOrientation orientation) {
    return SystemChrome.setPreferredOrientations([
      orientation,
    ]);
  }
}
