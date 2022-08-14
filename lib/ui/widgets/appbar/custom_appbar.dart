import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/appbar/base_appbar.dart';

abstract class CustomAppBar {
  /// Use [CustomAppBar.primary] as a default AppBar globally.
  /// * Can edited for specific requirement.
  static PreferredSizeWidget primary({
    /// test
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    VoidCallback? onPressed,
    List<Widget>? action,
    bool? centerTitle = false,
  }) {
    return BaseAppBar(
      title: title,
      centerTitle: true,
      action: action,
      backgroundColor: Colors.white,
      titleStyle: AppStyle.headline4.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      iconColor: AppColors.systemDarkGrey,
    );
  }

  /// Use [CustomAppBar.secondary] as an secondary AppBar for some pages.
  /// * Can edited for specific requirement.
  static PreferredSizeWidget secondary({
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    VoidCallback? onPressed,
    List<Widget>? action,
    bool? centerTitle,
  }) {
    return BaseAppBar(
      title: title,
      centerTitle: true,
      action: action,
      backgroundColor: backgroundColor,
      titleStyle: TextStyle(color: textColor),
      iconColor: Colors.white,
    );
  }

///
/// Add other AppBar if needed.
///
}