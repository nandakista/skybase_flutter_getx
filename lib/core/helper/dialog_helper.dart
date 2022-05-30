// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_dialog.dart';

// ----------------------------------------------------------------------------------------
//                               LOADING DIALOG
// ----------------------------------------------------------------------------------------

class Toast {
  static show(String message) {
    Fluttertoast.showToast(msg: message);
  }
}

// ----------------------------------------------------------------------------------------
//                               LOADING DIALOG
// ----------------------------------------------------------------------------------------

class Loading {
  static show(){
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => const LoadingDialog());
  }

  static hide() => Get.back();
}

// ----------------------------------------------------------------------------------------
//                               DIALOG
// ----------------------------------------------------------------------------------------
enum TypeDialog {
  FAILED,
  SUCCESS,
  WARNING,
  SOON,
}

class AppDialog {
  static show({required TypeDialog typeDialog, String? title, required String message, required Function onPress, bool? dismissible}) {
    switch (typeDialog) {
      case TypeDialog.FAILED:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => FailedDialog(
            title: title ?? "Gagal",
            description: message,
            onPress: () => onPress(),
          ),
        );
      case TypeDialog.SUCCESS:
        return showDialog(
          barrierDismissible: dismissible ?? false,
          context: Get.context!,
          builder: (context) => SuccessDialog(
            title: title ?? "Berhasil",
            description: message,
            onPress: () => onPress(),
          ),
        );
      case TypeDialog.WARNING:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => WarningDialog(
            title: title ?? "Peringatan!",
            description: message,
            confirmPress: () => onPress(),
            cancelPress: () => Get.back() ,
          ),
        );
      case TypeDialog.SOON:
        return showDialog(
          barrierDismissible: dismissible ?? true,
          context: Get.context!,
          builder: (context) => const CommingSoonDialog(),
        );
    }
  }

  static close() => Get.back();
}