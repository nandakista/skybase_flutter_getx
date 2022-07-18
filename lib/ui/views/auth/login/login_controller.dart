import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/auth_manager/auth_manager.dart';
import 'package:varcore_flutter_base/core/database/secure_storage/secure_storage_manager.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/data/data_sources/server/auth/auth_api.dart';
import 'package:varcore_flutter_base/ui/views/home/home_view.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_view.dart';

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

  login() async {
    if (validateField()) {
      try {
        Loading.show();
        await dataSource.login(
            phoneNumber: phoneController.text,
            email: emailController.text,
            password: passController.text).then((res) async {
          Loading.hide();
          Get.offAllNamed(HomeView.route);
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

  bypassLogin() async {
    await SecureStorageManager.to.logout();
    await SecureStorageManager.to.setToken(value: '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');
    AuthManager.to.setAuth();
  }
}
