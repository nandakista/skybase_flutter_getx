import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/domain/usecases/login.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

class LoginController extends GetxController {
  final Login login;
  LoginController({required this.login});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();

  RxBool isHiddenPassword = true.obs;

  void hidePassword() => isHiddenPassword.toggle();

  void onLogin() async {
    if (ValidatorHelper.validateForm(formKey)) {
      try {
        LoadingDialog.show();
        await login(
          phoneNumber: phoneController.text,
          email: emailController.text,
          password: passController.text,
        );
        LoadingDialog.dismiss();
        Get.offAllNamed(MainNavView.route);
      } catch (err) {
        LoadingDialog.dismiss();
        DialogHelper.failed(message: err.toString());
      }
    }
  }

  void bypassLogin() async {
    Get.offNamed(MainNavView.route);
    // await SecureStorageManager.find.setToken(value: 'dummy');
    // AuthManager.find.setAuth();
  }
}
