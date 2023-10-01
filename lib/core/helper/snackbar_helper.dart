import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SkySnackBarType { NORMAL, SUCCESS, ERROR, WARNING }

abstract class SnackBarHelper {
  static void custom({
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    ShapeBorder? shape,
    double? elevation,
  }) {
    showDefaultSnackBar(
      message: message ?? 'txt_success'.tr,
      type: SkySnackBarType.NORMAL,
      behavior: behavior,
      action: action,
      backgroundColor: backgroundColor,
      width: width,
      elevation: elevation,
      shape: shape,
      margin: margin,
      padding: padding,
    );
  }

  static void normal({
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      message: message ?? 'txt_success'.tr,
      type: SkySnackBarType.NORMAL,
      behavior: behavior,
      action: action,
    );
  }

  static void success({
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      message: message ?? 'txt_success'.tr,
      type: SkySnackBarType.SUCCESS,
      behavior: behavior,
      action: action,
    );
  }

  static void error({
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      message: message ?? 'txt_error'.tr,
      type: SkySnackBarType.ERROR,
      behavior: behavior,
      action: action,
    );
  }

  static void warning({
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      message: message ?? 'txt_warning'.tr,
      type: SkySnackBarType.WARNING,
      behavior: behavior,
      action: action,
    );
  }

  static void showDefaultSnackBar({
    required String message,
    SkySnackBarType type = SkySnackBarType.NORMAL,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? backgroundColor,
    double? width,
    ShapeBorder? shape,
    double? elevation,
  }) {
    Color bgColor = backgroundColor ?? Theme.of(Get.context!).primaryColor;
    bgColor = switch (type) {
      SkySnackBarType.ERROR => bgColor = Colors.red,
      SkySnackBarType.SUCCESS => bgColor = Colors.green,
      SkySnackBarType.WARNING => bgColor = Colors.orange,
      SkySnackBarType.NORMAL => bgColor = Colors.black,
    };

    final snackBar = SnackBar(
      width: width,
      elevation: elevation,
      shape: shape,
      action: action,
      margin: margin,
      padding: padding,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      behavior: behavior ?? SnackBarBehavior.floating,
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
