import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SkySnackBarType { normal, success, error, warning }

abstract class SkySnackBar {
  static void showNormal({
    required String? message,
  }) {
    showDefaultSnackBar(
      message: message ?? 'Success',
      type: SkySnackBarType.normal,
    );
  }

  static void showSuccess({
    required String? message,
  }) {
    showDefaultSnackBar(
      message: message ?? 'Success',
      type: SkySnackBarType.success,
    );
  }

  static void showError({
    required String? message,
  }) {
    showDefaultSnackBar(
      message: message ?? 'Error',
      type: SkySnackBarType.error,
    );
  }

  static void showWarning({
    required String? message,
  }) {
    showDefaultSnackBar(
      message: message ?? 'Warning',
      type: SkySnackBarType.warning,
    );
  }

  static void showDefaultSnackBar({
    required String message,
    SkySnackBarType type = SkySnackBarType.normal,
  }) {
    Color backgroundColor = Theme.of(Get.context!).primaryColor;

    switch (type) {
      case SkySnackBarType.error:
        backgroundColor = Colors.red;
        break;
      case SkySnackBarType.success:
        backgroundColor = Colors.green;
        break;
      case SkySnackBarType.warning:
        backgroundColor = Colors.orange;
        break;
      case SkySnackBarType.normal:
        backgroundColor = Colors.black;
        break;

    }

    final snackBar = SnackBar(
      content: Text(message),
      // duration: const Duration(milliseconds: 400),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
