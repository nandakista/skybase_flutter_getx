import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

class LoginController extends GetxController {
  final AuthRepository repository;
  CancelToken cancelToken = CancelToken();

  LoginController({required this.repository});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  RxBool isHiddenPassword = true.obs;

  void hidePassword() => isHiddenPassword.toggle();

  void login() async {
    if (ValidatorHelper.validateForm(formKey)) {
      try {
        LoadingDialog.show();
        await repository.login(
          phoneNumber: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
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
    LoadingDialog.show();
    try {
      final response = await repository.getProfile(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      LoadingDialog.dismiss();
      AuthManager.find.login(
        user: response,
        token: 'dummy',
        refreshToken: 'dummyRefresh',
      );
    } catch (e) {
      LoadingDialog.dismiss();
      DialogHelper.failed(message: e.toString());
    }
  }
}
