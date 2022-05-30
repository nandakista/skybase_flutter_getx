import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_style.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: materialPrimaryColor,
  primarySwatch: materialPrimaryColor,
  fontFamily: "Poppins",
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      statusBarColor: primaryColor,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: materialPrimaryColor,
  primarySwatch: materialPrimaryColor,
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      statusBarColor: primaryColor,
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
    statusBarColor: primaryColor,
  );
}

setPotraitOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}