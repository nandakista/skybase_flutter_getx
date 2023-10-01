import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/config/themes/app_colors.dart';

class PermissionHelper {
  static void openSettings(String message) {
    Get.snackbar(
      'txt_permission_warning'.tr,
      message,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: openAppSettings,
        child: Text(
          'txt_open_setting'.tr,
          style: Get.textTheme.bodySmall?.copyWith(
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }

  static void error(String message, {Color? backgroundColor}) {
    Get.snackbar(
      'txt_permission_warning'.tr,
      message,
      backgroundColor: backgroundColor ?? Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  static Future<bool> isMultiplePermissionGranted(
      List<Permission> permissions, {
        String? permanentlyDeniedMsg,
        String? deniedMsg,
      }) async {
    Map<Permission, PermissionStatus> permissionList = await permissions.request();
    if (permissionList.values.contains(PermissionStatus.permanentlyDenied)) {
      PermissionHelper.openSettings(
        permanentlyDeniedMsg ?? 'txt_need_several_permission'.tr,
      );
      return false;
    } else if (permissionList.values.every((e) => e.isGranted)) {
      return true;
    } else if (permissionList.values.contains(PermissionStatus.denied)) {
      PermissionHelper.error(deniedMsg ?? 'txt_permission_warning'.tr);
      return false;
    } else {
      PermissionHelper.error(deniedMsg ?? 'txt_permission_warning'.tr);
      return false;
    }
  }

  /// This permission to open folder downloaded
  /// But it's very sensitive
  /// As much as posible avoid request this permission
  static Future<bool> manageExternalStorage() async {
    if (Platform.isAndroid) {
      final mPermission = await Permission.manageExternalStorage.request();
      if (mPermission.isPermanentlyDenied) {
        LoadingDialog.dismiss();
        PermissionHelper.openSettings('txt_need_permission_storage'.tr);
        return false;
      } else if (mPermission.isGranted) {
        return true;
      } else {
        SnackBarHelper.warning(message: 'txt_need_permission_storage'.tr);
        return false;
      }
    } else {
      return true;
    }
  }
}
