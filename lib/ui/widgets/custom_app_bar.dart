import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

abstract class CustomAppBar {

  /// Use [CustomAppBar.primary] as a default AppBar globally.
  /// * Can edited for specific requirement.
  static PreferredSize primary({
    /// test
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    VoidCallback? onPressed,
    List<Widget>? action,
    bool? centerTitle = false,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        centerTitle: centerTitle,
        title: Text(
          title ?? '',
          style: TextStyle(
            color:
            textColor ?? ((Get.isDarkMode) ? Colors.white : Colors.black),
          ),
        ),
        backgroundColor: backgroundColor ??
            ((Get.isDarkMode) ? AppColors.baseDark : AppColors.baseLight),
        elevation: 0,
        leading: (Navigator.canPop(Get.context!))
            ? Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: Icon(
                (Platform.isAndroid) ? Icons.arrow_back : Icons.arrow_back_ios_rounded,
                color: iconColor ??
                    (Get.isDarkMode ? AppColors.primary : Colors.black),
              ),
              onPressed: onPressed ?? () => Get.back()),
        )
            : null,
        actions: action,
      ),
    );
  }

  /// Use [CustomAppBar.secondary] as an secondary AppBar for some pages.
  /// * Can edited for specific requirement.
  static PreferredSize secondary({
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    VoidCallback? onPressed,
    List<Widget>? action,
    bool? centerTitle,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        centerTitle: centerTitle,
        title: Text(
          title ?? '',
          style: const TextStyle(
            color:
            Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: (Navigator.canPop(Get.context!))
            ? Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: Icon(
                (Platform.isAndroid) ? Icons.arrow_back : Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: onPressed ?? () => Get.back()),
        )
            : null,
        actions: action,
      ),
    );
  }


  ///
  /// Add other AppBar if needed.
  ///
}
