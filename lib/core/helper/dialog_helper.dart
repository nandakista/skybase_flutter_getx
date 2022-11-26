// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

//---------------<Toast>-----------------
class Toast {
  static show(String message) {
    Fluttertoast.showToast(msg: message);
  }
}

//---------------<Loading Dialog>-----------------
class Loading {
  static show({bool? dismissible}) {
    return showDialog(
        barrierDismissible: dismissible ?? false,
        context: Get.context!,
        builder: (context) => const LoadingDialog());
  }

  static hide() => Get.back();
}

//---------------<Custom Dialog>-----------------
enum DialogType {
  FAILED,
  SUCCESS,
  WARNING,
  RETRY,
  SOON,
  PERMISSION,
}

class SkyDialog {
  static show({
    required DialogType type,
    String? title,
    required String message,
    required VoidCallback onPress,
    VoidCallback? onCancel,
    bool? dismissible,
    String? confirmText,
    Widget? header,
    Color? backgroundColorHeader = Colors.transparent,
  }) {
    switch (type) {
      case DialogType.FAILED:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.error(
            title: title ?? 'txt_failed'.tr,
            description: message,
            onConfirm: onPress,
          ),
        );
      case DialogType.SUCCESS:
        return showDialog(
          barrierDismissible: dismissible ?? false,
          context: Get.context!,
          builder: (context) => DialogAlert.success(
            title: title ?? 'txt_success'.tr,
            description: message,
            onConfirm: onPress,
          ),
        );
      case DialogType.WARNING:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.warning(
            title: title ?? 'txt_warning'.tr,
            backgroundColorHeader: Colors.orange,
            description: message,
            onConfirm: onPress,
            onCancel: onCancel ?? () => Get.back(),
          ),
        );
      case DialogType.SOON:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => const SoonDialog(),
        );
      case DialogType.RETRY:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.retry(
            title: title ?? 'txt_failed'.tr,
            description: message,
            onConfirm: onPress,
            onCancel: onCancel ?? () => Get.back(),
          ),
        );
      case DialogType.PERMISSION:
        return showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => DialogAlert.permission(
            header: header,
            backgroundColorHeader: Colors.orange,
            title: title ?? 'txt_warning'.tr,
            description: message,
            onConfirm: onPress,
            onCancel: onCancel ?? () => Get.back(),
            confirmText: confirmText ?? 'OK',
          ),
        );
    }
  }

  static close() => Get.back();
}
