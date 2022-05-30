import 'package:flutter/material.dart';
import 'package:get/get.dart';

Text textVersiApp = Text("Ver 1.0", style: baseFontStyle);

// -------<Color Style>-------
// General
const Color primaryColor = Color(0xff5275C1);
const Color disabledPrimaryColor = Color(0xffCAFFD9);
const Color secondaryColor = Color(0xffFFDB29);
const Color accentColor = Color(0xffCAFFD9);
const Color systemGreyColor = Color(0xffF1F1F1);
const Color systemBlackColor = Color(0xff141414);
const Color systemDarkGreyColor = Color(0xffB8B8B8);
const Color systemBgDarkColor = Color(0xff303030);
const Color systemBgLightColor = Color(0xffFAFAFA);
const Color subtitleTextColor = Color(0xff504F5E);
Color containerThemeColor = (Get.isDarkMode) ? Get.context!.theme.dialogBackgroundColor : systemGreyColor;

// Dark Mode
const Color baseDarkColor = Color(0xff303030);
const Color baseLightColor = Color(0xffFAFAFA);

// Material Color
Map<int, Color> color = {
  50: const Color.fromRGBO(255, 255, 255, 1.0),
  100: const Color.fromRGBO(255, 255, 255, 0.9294117647058824),
  200: const Color.fromRGBO(255, 255, 255, 1.0),
  300: const Color.fromRGBO(213, 209, 211, 1.0),
  400: const Color.fromRGBO(199, 198, 199, 1.0),
  500: const Color.fromRGBO(179, 175, 177, 1.0),
  600: const Color.fromRGBO(156, 155, 156, 1.0),
  700: const Color.fromRGBO(139, 136, 137, 1.0),
  800: const Color.fromRGBO(68, 68, 68, 1.0),
  900: const Color.fromRGBO(45, 45, 45, 1.0),
};
MaterialColor materialPrimaryColor = MaterialColor(0xFF5275C1, color);

// -------<Font Style>-------
TextStyle baseFontStyleVeryBig = const TextStyle(fontSize: 34);
TextStyle baseFontStyleBig = const TextStyle(fontSize: 24);
TextStyle baseFontStyle = const TextStyle(fontSize: 16);
TextStyle baseFontStyleSmall = const TextStyle(fontSize: 14);
TextStyle baseFontStyleVerySmall = const TextStyle(fontSize: 12);

// Font Weight
FontWeight semiBoldWeight = FontWeight.w600;
FontWeight mediumWeight = FontWeight.w500;
FontWeight regularWeight = FontWeight.w400;

TextStyle titleFontStyle = const TextStyle(
    fontSize: 26, fontWeight: FontWeight.w800, color: primaryColor);
TextStyle title2FontStyle = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w700, color: primaryColor);
TextStyle subtitleFontStyle = baseFontStyleSmall.copyWith(
    color: subtitleTextColor, fontWeight: regularWeight);
TextStyle formTitleStyle = baseFontStyle.copyWith(fontWeight: mediumWeight);

TextStyle baseLinkFontStyle = const TextStyle(fontSize: 18, color: Colors.blue);
