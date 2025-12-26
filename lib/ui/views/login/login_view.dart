import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/extension/context_extension.dart';
import 'package:skybase/core/helper/validator.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/views/login/login_controller.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/keyboard_dismissible.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class LoginView extends GetView<LoginController> {
  static const String route = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: ColoredStatusBar(
        color: Get.theme.scaffoldBackgroundColor,
        brightness: Brightness.light,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                            Text('txt_login'.tr, style: context.typography.headline2),
                            const SizedBox(height: 10),
                            Text(
                              'txt_login_subtitle'.tr,
                              style: context.typography.subtitle4,
                            ),
                          ],
                        ),
                      ),
                      const Flexible(
                        child: FlutterLogo(size: 160),
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
                        SkyFormField(
                          label: 'txt_phone'.tr,
                          hint: 'txt_phone'.tr,
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          isRequired: true,
                          validator: Validator.phone(),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => SkyPasswordFormField(
                            label: 'txt_password'.tr,
                            hint: 'txt_password'.tr,
                            controller: controller.passwordController,
                            icon: Icons.lock,
                            hiddenText: controller.isHiddenPassword.value,
                            endIcon: IconButton(
                                icon: const Icon(Icons.visibility_off),
                                onPressed: () => controller.hidePassword()),
                            validator: Validator.password(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SkyButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.login();
                          },
                          text: 'txt_login'.tr,
                          icon: Icons.arrow_forward,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      SkyButton(
                        onPressed: () => controller.bypassLogin(),
                        text: 'txt_skip'.tr,
                        icon: Icons.arrow_forward,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('txt_forgot_password'.tr),
                          InkWell(
                            child: Text(
                              'txt_reset'.tr,
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
                          Text('txt_dont_have_account'.tr),
                          InkWell(
                            child: Text(
                              'txt_register'.tr,
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
          ),
        ),
      ),
    );
  }
}
