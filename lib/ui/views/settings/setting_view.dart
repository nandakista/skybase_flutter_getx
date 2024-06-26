import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/app/app_info.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/views/settings/setting_controller.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SettingView extends GetView<SettingController> {
  static const String route = '/setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      brightness: Brightness.dark,
      child: Scaffold(
        appBar: SkyAppBar.secondary(title: 'txt_setting'.tr),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${'txt_version'.tr} ${AppInfo.appVersion}',
                style: AppStyle.body2.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SkyButton(
                onPressed: () => controller.onLogout(),
                text: 'txt_logout'.tr,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text('txt_language'.tr)),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('ENG'),
                        Obx(
                          () => Radio(
                            value: 'en',
                            groupValue: controller.languageCode.value,
                            onChanged: (value) {
                              controller.onUpdateLocale(value.toString());
                            },
                          ),
                        ),
                        const Text('ID'),
                        Obx(
                          () => Radio(
                            value: 'id',
                            groupValue: controller.languageCode.value,
                            onChanged: (value) {
                              controller.onUpdateLocale(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('txt_dark_mode'.tr),
                  GetX<ThemeManager>(
                    builder: (controller) => Switch(
                      value: controller.isDark.value,
                      onChanged: (value) {
                        controller.changeTheme();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
