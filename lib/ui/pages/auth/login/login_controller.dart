import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/data/data_sources/auth/auth_datasource.dart';
import 'package:varcore_flutter_base/ui/pages/home/home_page.dart';

class LoginController extends GetxController {
  final AuthDatasource dataSource;
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
          // Get.toNamed(OtpPage.routeName, arguments: [
          //   res.isLogin,
          //   phoneController.text,
          // ]);
          Get.offAllNamed(HomePage.routeName);
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
}
