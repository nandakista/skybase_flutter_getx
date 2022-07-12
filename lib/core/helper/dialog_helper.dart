// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_dialog.dart';

//---------------<Toast>-----------------
class Toast {
  static show(String message) {
    Fluttertoast.showToast(msg: message);
  }
}

//---------------<Loading Dialog>-----------------
class Loading {
  static show() {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => const LoadingDialog());
  }

  static hide() => Get.back();
}

//---------------<Custom Dialog>-----------------
enum TypeDialog {
  FAILED,
  SUCCESS,
  WARNING,
  RETRY,
  SOON,
}

class AppDialog {
  static show({
    required TypeDialog typeDialog,
    String? title,
    required String message,
    required VoidCallback onPress,
    VoidCallback? onCancel,
    bool? dismissible,
  }) {
    switch (typeDialog) {
      case TypeDialog.FAILED:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.error(
            title: title ?? 'Gagal',
            description: message,
            onConfirm: onPress,
          ),
        );
      case TypeDialog.SUCCESS:
        return showDialog(
          barrierDismissible: dismissible ?? false,
          context: Get.context!,
          builder: (context) => DialogAlert.success(
            title: title ?? 'Berhasil',
            description: message,
            onConfirm: onPress,
          ),
        );
      case TypeDialog.WARNING:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.warning(
            title: title ?? 'Peringatan!',
            description: message,
            onConfirm: onPress,
            onCancel: onCancel ?? () => Get.back(),
          ),
        );
      case TypeDialog.SOON:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => const SoonDialog(),
        );
      case TypeDialog.RETRY:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.retry(
            title: title ?? 'Gagal!',
            description: message,
            onConfirm: onPress,
            onCancel: onCancel ?? () => Get.back(),
          ),
        );
    }
  }

  static close() => Get.back();
}
