import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'app_style.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.materialPrimary,
  primarySwatch: AppColors.materialPrimary,
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
  /// is dark mode currently enabled?
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

setStatusBarColor(){
  return const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: AppColors.primary,
  );
}

setPotraitOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}