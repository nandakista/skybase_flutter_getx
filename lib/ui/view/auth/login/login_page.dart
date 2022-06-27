import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/validator_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_form_field.dart';

class LoginPage extends GetView<LoginController> {
  static const String route = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: ContentWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Log In ', style: AppStyle.headline2),
                            const SizedBox(height: 10),
                            Text('Masukkan No.Handphone dan password anda. ',
                                style: AppStyle.subtitle4),
                          ],
                        ),
                      ),
                      const Flexible(
                        child: Image(
                            image: AssetImage('assets/img_login.png'),
                            width: 250),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        CustomFieldForm(
                          label: 'No.Handphone',
                          hint: 'No.Handphone',
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          validator: (value) => AppValidator.field(
                            title: 'Nomor Telepon',
                            value: value.toString(),
                            regex: AppRegex.phone,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomPasswordFieldForm(
                            label: 'Password',
                            hint: 'Password',
                            controller: controller.passController,
                            icon: Icons.lock,
                            hiddenText: controller.isHiddenPassword.value,
                            endIcon: IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () => controller.hidePassword()),
                            validator: (value) => AppValidator.field(
                              title: 'Password',
                              value: value.toString(),
                              regex: AppRegex.password,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                            onPress: () {
                              FocusScope.of(context).unfocus();
                              controller.login();
                            },
                            text: 'Log In',
                            icon: Icons.arrow_forward,
                            color: AppColors.primary),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('Belum memiliki akun ? '),
                                InkWell(
                                  child: Text(
                                    'Daftar',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('Lupa password ? '),
                                InkWell(
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
