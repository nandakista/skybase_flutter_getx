import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/localization/locale_helper.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SettingsUtilsView extends GetView<UtilsController> {
  const SettingsUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Settings Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is Dark Mode'),
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
            SkyButton(
              onPressed: () => LocaleHelper().showLocaleDialog(context),
              text: 'txt_change_language'.tr,
              icon: CupertinoIcons.paintbrush,
            ),
          ],
        ),
      ),
    );
  }
}
