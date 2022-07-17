import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/validator_helper.dart';
import 'package:varcore_flutter_base/core/localization/lang_const.dart';
import 'package:varcore_flutter_base/core/localization/locale_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_form_field.dart';

class LoginView extends GetView<LoginController> {
  static const String route = '/login';
  const LoginView({Key? key}) : super(key: key);

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
                            Text(MultiLangs.login.tr, style: AppStyle.headline2),
                            const SizedBox(height: 10),
                            Text(MultiLangs.loginSubtitle.tr,
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
                          label: MultiLangs.phone.tr,
                          hint: MultiLangs.phone.tr,
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          validator: (value) => AppValidator.field(
                            title: MultiLangs.phone.tr,
                            value: value.toString(),
                            regex: AppRegex.phone,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomPasswordFieldForm(
                            label: MultiLangs.password.tr,
                            hint: MultiLangs.password.tr,
                            controller: controller.passController,
                            icon: Icons.lock,
                            hiddenText: controller.isHiddenPassword.value,
                            endIcon: IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () => controller.hidePassword()),
                            validator: (value) => AppValidator.field(
                              title: MultiLangs.password.tr,
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
                            text: MultiLangs.login.tr,
                            icon: Icons.arrow_forward,
                            color: AppColors.primary),

                        CustomButton(
                            onPress: () {
                              LocaleHelper().showLocaleDialog(context);
                            },
                            text: MultiLangs.changeLanguage.tr,
                            icon: Icons.arrow_forward,
                            color: AppColors.primary),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(MultiLangs.dontHaveAccount.tr),
                                InkWell(
                                  child: Text(
                                    MultiLangs.register.tr,
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(MultiLangs.forgotPassword.tr),
                                 InkWell(
                                  child: Text(
                                    MultiLangs.reset.tr,
                                    style: const TextStyle(
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
