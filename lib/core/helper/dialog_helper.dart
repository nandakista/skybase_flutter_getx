// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

class Loading {
  static show({bool? dismissible}) {
    return showGeneralDialog(
      context: Get.context!,
      barrierLabel: 'Barrier',
      barrierDismissible: dismissible ?? false,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const PlatformLoadingIndicator(),
          ),
        );
      },
    );
  }

  static dismiss() => Get.back();
}

enum DialogType {
  FAILED,
  SUCCESS,
  WARNING,
  RETRY,
  FORCE,
}

class SkyDialog {
  static show({
    required DialogType type,
    String? title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool? isDismissible,
    String? confirmText,
    Widget? header,
    Color? backgroundColorHeader = Colors.transparent,
    String? cancelText,
  }) {
    switch (type) {
      case DialogType.FAILED:
        return showDialog(
          barrierDismissible: isDismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.error(
            title: title ?? 'txt_failed'.tr,
            description: message,
            onConfirm: onConfirm,
            isDismissible: isDismissible?? true,
          ),
        );
      case DialogType.SUCCESS:
        return showDialog(
          barrierDismissible: isDismissible ?? false,
          context: Get.context!,
          builder: (context) => DialogAlert.success(
            title: title ?? 'txt_success'.tr,
            description: message,
            onConfirm: onConfirm,
            isDismissible: isDismissible?? false,
          ),
        );
      case DialogType.WARNING:
        return showDialog(
          barrierDismissible: isDismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.warning(
            title: title ?? 'txt_warning'.tr,
            backgroundColorHeader: Colors.orange,
            description: message,
            onConfirm: onConfirm,
            confirmText: confirmText,
            cancelText: cancelText,
            onCancel: onCancel ?? () => Get.back(),
            isDismissible: isDismissible?? false,
          ),
        );
      case DialogType.RETRY:
        return showDialog(
          barrierDismissible: isDismissible ?? true,
          context: Get.context!,
          builder: (context) => DialogAlert.retry(
            title: title ?? 'txt_failed'.tr,
            description: message,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel ?? () => Get.back(),
            isDismissible: isDismissible?? true,
          ),
        );
      case DialogType.FORCE:
        return showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => DialogAlert.force(
            header: header,
            backgroundColorHeader: Colors.orange,
            title: title ?? 'txt_warning'.tr,
            description: message,
            onConfirm: onConfirm,
            onCancel: onCancel ?? () => Get.back(),
            confirmText: confirmText ?? 'OK',
            isDismissible: isDismissible?? false,
          ),
        );
    }
  }

  static dismiss() => Get.back();
}
