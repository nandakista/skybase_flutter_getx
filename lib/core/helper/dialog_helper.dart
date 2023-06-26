import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

class LoadingDialog {
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

class DialogHelper {
  static failed({
    required String message,
    VoidCallback? onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
  }) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: Get.context!,
      builder: (context) => DialogAlert.error(
        header: header,
        title: title ?? 'txt_failed'.tr,
        description: message,
        onConfirm: onConfirm ?? dismiss,
        isDismissible: isDismissible ?? true,
      ),
    );
  }

  static success({
    required String message,
    required VoidCallback onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
  }) {
    return showDialog(
      barrierDismissible: isDismissible ?? false,
      context: Get.context!,
      builder: (context) => DialogAlert.success(
        header: header,
        title: title ?? 'txt_success'.tr,
        description: message,
        onConfirm: onConfirm,
        isDismissible: isDismissible ?? false,
      ),
    );
  }

  static warning({
    required String message,
    required VoidCallback onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
    String? confirmText,
    String? cancelText,
    VoidCallback? onCancel,
}) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: Get.context!,
      builder: (context) => DialogAlert.warning(
        header: header,
        isDismissible: isDismissible ?? false,
        title: title ?? 'txt_warning'.tr,
        description: message,
        backgroundColorHeader: Colors.orange,
        onConfirm: onConfirm,
        confirmText: confirmText,
        onCancel: onCancel ?? dismiss,
        cancelText: cancelText,
      ),
    );
  }

  static retry({
    required String message,
    required VoidCallback onConfirm,
    bool? isDismissible,
    Widget? header,
    String? title,
    String? confirmText,
    String? cancelText,
    VoidCallback? onCancel,
}) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: Get.context!,
      builder: (context) => DialogAlert.retry(
        header: header,
        title: title ?? 'txt_failed'.tr,
        description: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel ?? dismiss,
        isDismissible: isDismissible ?? true,
      ),
    );
  }

  static force({
    required String message,
    required VoidCallback onConfirm,
    bool? isDismissible,
    Widget? header,
    String? title,
    VoidCallback? onCancel,
    String? confirmText,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => DialogAlert.force(
        header: header,
        backgroundColorHeader: Colors.orange,
        title: title ?? 'txt_warning'.tr,
        description: message,
        onConfirm: onConfirm,
        onCancel: onCancel ?? dismiss,
        confirmText: confirmText ?? 'OK',
        isDismissible: isDismissible ?? false,
      ),
    );
  }

  static dismiss() => Get.back();
}
