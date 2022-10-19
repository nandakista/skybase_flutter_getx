import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/sources/server/auth/auth_api.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

class LoginController extends GetxController {
  final AuthApi dataSource;
  LoginController({required this.dataSource});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  RxBool isHiddenPassword = true.obs;
  hidePassword() => isHiddenPassword.toggle();

  bool validateField() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  void login() async {
    if (validateField()) {
      try {
        Loading.show();
        await dataSource.login(
            phoneNumber: phoneController.text,
            email: emailController.text,
            password: passController.text).then((res) async {
          Loading.hide();
          Get.offAllNamed(MainNavView.route);
        });
      } catch (err) {
        Loading.hide();
        AppDialog.show(
          typeDialog: TypeDialog.FAILED,
          message: err.toString(),
          onPress: () => AppDialog.close(),
        );
      }
    }
  }

  void bypassLogin() async {
    Get.toNamed(MainNavView.route);
    // await SecureStorageManager.find.setToken(value: 'dummy');
    // AuthManager.find.setAuth();
  }
}
