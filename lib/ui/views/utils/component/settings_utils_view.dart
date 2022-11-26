import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/converter_helper.dart';
import 'package:skybase/core/helper/date_time_helper.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/extension/int_extension.dart';
import 'package:skybase/core/helper/input_formater.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

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
            const SizedBox(height: 12),
            Text(
                'Sample Currency Format = ${controller.currency.currencyFormat()}'),
            const SizedBox(height: 12),
            SkyFormField(
              controller: controller.currencyCtr,
              initialValue: 0.toStringIDR(),
              label: 'txt_price'.tr,
              hint: 'txt_price'.tr,
              keyboardType: TextInputType.number,
              onChanged: (value) => (value.isEmpty)
                  ? controller.currencyCtr.text = 0.toStringIDR()
                  : value,
              validator: (value) => AppValidator.generalField('$value'),
              inputFormatters: CustomInputFormatters.idrCurrency,
              onFieldSubmitted: (value) => Toast.show(value),
            ),
            const SizedBox(height: 12),
            SkyButton(
              onPressed: () {
                String? converted = AppConverter.replaceStringRange(
                    'name@email.com', 2, 5, '*');
                debugPrint('Converted = $converted');
                Toast.show('String converted :\n $converted');
              },
              text: 'txt_convert'.tr + ' String',
              icon: CupertinoIcons.t_bubble,
            ),
          ],
        ),
      ),
    );
  }
}
