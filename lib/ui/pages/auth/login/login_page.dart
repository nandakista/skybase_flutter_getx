import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/validator_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/pages/auth/login/login_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_form_field.dart';

class LoginPage extends GetView<LoginController> {
  static String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Content(
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
                            Text("Log In ", style: titleFontStyle),
                            const SizedBox(height: 10),
                            Text("Masukkan No.Handphone dan password anda. ",
                                style: baseFontStyle),
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
                          label: "No.Handphone",
                          hint: "No.Handphone",
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          validator: (value) =>
                              TelephoneFieldValidator.validate(value!),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                              () => CustomPasswordFieldForm(
                            label: "Password",
                            hint: "Password",
                            controller: controller.passController,
                            icon: Icons.lock,
                            hiddenText: controller.isHiddenPassword.value,
                            endIcon: IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () => controller.hidePassword()),
                            validator: (value) =>
                                PasswordLoginFieldValidator.validate(value!),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButtonIcon(
                            onPress: () {
                              FocusScope.of(context).unfocus();
                              controller.login();
                            },
                            text: "Log In",
                            icon: Icons.arrow_forward,
                            color: primaryColor),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Belum memiliki akun ? ",
                                    style: baseFontStyleSmall),
                                InkWell(
                                    // onTap: () => Get.toNamed(AgreementPage.routeName),
                                    child: Text("Daftar",
                                        style: baseFontStyleSmall.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Lupa password ? ",
                                    style: baseFontStyleSmall),
                                InkWell(
                                    // onTap: () => Get.toNamed(PasswordResetPage.routeName),
                                    child: Text("Reset",
                                        style: baseFontStyleSmall.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold))),
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