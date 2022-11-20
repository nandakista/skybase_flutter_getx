import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skybase/core/themes/app_colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColors.materialPrimary,
      primarySwatch: AppColors.materialPrimary,
      toggleableActiveColor: AppColors.materialPrimary,
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
  }

  static ThemeData dark() {
    return ThemeData(
      primarySwatch: AppColors.materialPrimary,
      primaryColor: AppColors.materialPrimary,
      toggleableActiveColor: AppColors.materialPrimary,
      indicatorColor: AppColors.accent,
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          statusBarColor: AppColors.primary,
        ),
      ),
    );
  }

  static setStatusBar({
    required Brightness brightness,
    Color color = AppColors.primary,
  }) {
    Brightness _iconBrightness;
    if (Platform.isIOS) {
      (brightness == Brightness.dark)
          ? _iconBrightness = Brightness.light
          : _iconBrightness = Brightness.dark;
    } else {
      _iconBrightness = brightness;
    }
    return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: _iconBrightness,
        statusBarColor: color,
      ),
    );
  }
}

extension DarkMode on BuildContext {
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

class AppOrientation {
  static lock(DeviceOrientation orientation) {
    return SystemChrome.setPreferredOrientations([
      orientation,
    ]);
  }
}
