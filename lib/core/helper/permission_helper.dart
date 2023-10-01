import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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

  static Future<bool> isCameraGranted({
    bool showDeniedMessage = true,
    String? permanentlyDeniedMsg,
    String deniedMsg = 'txt_need_permission_camera',
  }) async {
    bool isGranted = await Permission.camera.status.isGranted;
    if (isGranted) return true;

    final permission = await Permission.camera.request();
    _handleDialog(
      permission: permission,
      permanentlyDeniedMsg: permanentlyDeniedMsg ?? deniedMsg.tr,
      deniedMsg: (showDeniedMessage) ? deniedMsg.tr : null,
    );
    return permission.isGranted;
  }

  static Future<bool> isStorageGranted({
    bool showDeniedMessage = true,
    String? permanentlyDeniedMsg,
    String deniedMsg = 'txt_need_permission_storage',
  }) async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (isGranted) return true;

    final permission = await Permission.storage.request();
    _handleDialog(
      permission: permission,
      permanentlyDeniedMsg: permanentlyDeniedMsg ?? deniedMsg.tr,
      deniedMsg: (showDeniedMessage) ? deniedMsg.tr : null,
    );
    return permission.isGranted;
  }

  static Future<bool> isPhotoGranted({
    bool showDeniedMessage = false,
    String? permanentlyDeniedMsg,
    String deniedMsg = 'txt_need_permission_gallery_photo',
  }) async {
    bool isGranted = await Permission.photos.status.isGranted;
    if (isGranted) return true;

    final permission = await Permission.photos.request();
    if (Platform.isIOS) {
      if (permission.isPermanentlyDenied) {
        openSettings(permanentlyDeniedMsg ?? deniedMsg.tr);
        return false;
      }
      return true;
    } else {
      _handleDialog(
        permission: permission,
        permanentlyDeniedMsg: permanentlyDeniedMsg ?? deniedMsg.tr,
        deniedMsg: (showDeniedMessage) ? deniedMsg.tr : null,
      );
      return permission.isGranted;
    }
  }

  static Future<bool> isMultiplePermissionGranted(
    List<Permission> permissions, {
    String? permanentlyDeniedMsg,
    String deniedMsg = 'txt_need_several_permission',
  }) async {
    Map<Permission, PermissionStatus> permissionList =
        await permissions.request();
    if (permissionList.values.contains(PermissionStatus.permanentlyDenied)) {
      PermissionHelper.openSettings(permanentlyDeniedMsg ?? deniedMsg.tr);
      return false;
    } else if (permissionList.values.every((e) => e.isGranted)) {
      return true;
    } else if (permissionList.values.contains(PermissionStatus.denied)) {
      PermissionHelper.error(deniedMsg.tr);
      return false;
    } else {
      PermissionHelper.error(deniedMsg.tr);
      return false;
    }
  }

  /// This permission to open folder downloaded
  /// But it's very sensitive
  /// As much as possible avoid request this permission
  static Future<bool> manageExternalStorage({
    String deniedMsg = 'txt_need_permission_storage',
  }) async {
    if (Platform.isAndroid) {
      final permission = await Permission.manageExternalStorage.request();
      if (permission.isPermanentlyDenied) {
        PermissionHelper.openSettings(deniedMsg.tr);
      } else {
        SnackBarHelper.warning(message: deniedMsg.tr);
      }
      return permission.isGranted;
    } else {
      return true;
    }
  }

  /// **Note:**
  /// Will show *open setting* message if **Permission.permanentlyDenied**
  /// and optionally show *error* message if **Permission.isDenied**
  static void _handleDialog({
    required PermissionStatus permission,
    required String permanentlyDeniedMsg,
    String? deniedMsg,
  }) {
    switch (permission) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.permanentlyDenied:
        openSettings(permanentlyDeniedMsg);
      case PermissionStatus.denied:
        if (deniedMsg != null) error(deniedMsg);
      default:
    }
  }
}
