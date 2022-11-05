import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/helper/converter_helper.dart';
import 'package:skybase/core/helper/extension/int_extension.dart';
import 'package:skybase/ui/views/utils/bottom_sheet_utils_view.dart';
import 'package:skybase/ui/views/utils/list_utils_view.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/views/utils/media_utils_view.dart';
import 'package:skybase/ui/widgets/date_picker_widget.dart';
import 'package:skybase/core/helper/date_time_helper.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/input_formater.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class UtilsView extends GetView<UtilsController> {
  const UtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Utility'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentWrapper(
            top: true,
            bottom: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkyButton(
                  text: 'Media Utility',
                  icon: Icons.photo_library_outlined,
                  outlineMode: true,
                  onPressed: () => Get.to(const MediaUtilsView()),
                ),
                SkyButton(
                  text: 'BottomSheet Utility',
                  icon: Icons.account_tree_outlined,
                  outlineMode: true,
                  onPressed: () => Get.to(const BottomSheetUtilsView()),
                ),
                SkyButton(
                  text: 'List Utility',
                  icon: Icons.account_tree_outlined,
                  outlineMode: true,
                  onPressed: () => Get.to(const ListUtilsView()),
                ),
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
                Text(
                    'Sample Currency Format = ${controller.currency.currencyFormat()}'),
                const SizedBox(height: 12),
                SkyButton(
                  onPressed: () => LocaleHelper().showLocaleDialog(context),
                  text: International.changeLanguage.tr,
                  icon: CupertinoIcons.paintbrush,
                ),
                SkyButton(
                  onPressed: () {
                    AppDialog.show(
                      typeDialog: TypeDialog.WARNING,
                      message: 'Dialog',
                      onPress: () => AppDialog.close(),
                    );
                  },
                  text: 'Dialog',
                  icon: CupertinoIcons.conversation_bubble,
                ),
                SkyButton(
                  onPressed: () {
                    Loading.show(dismissible: true);
                  },
                  text: 'Loading',
                  icon: CupertinoIcons.refresh_thick,
                ),
                SkyButton(
                  onPressed: () {
                    String? converted = DateTimeHelper(
                            startDate: DateTime.now(), endDate: DateTime.now())
                        .format();
                    Toast.show('Date converted :\n $converted');
                  },
                  text: International.convert.tr + ' ' + International.date.tr,
                ),
                SkyButton(
                  onPressed: () {
                    BottomSheetHelper.basic(
                      child: DatePickerWidget.range(
                        onSelectionChanged: (selected) {},
                      ),
                    );
                  },
                  text: 'Bottom Sheet + Date Range',
                  icon: Icons.date_range_outlined,
                ),
                SkyButton(
                  onPressed: () {
                    String? converted = AppConverter.replaceStringRange(
                        'name@email.com', 2, 5, '*');
                    debugPrint('Converted = $converted');
                    Toast.show('String converted :\n $converted');
                  },
                  text: International.convert.tr + ' String',
                  icon: CupertinoIcons.t_bubble,
                ),
                const SizedBox(height: 12),
                SkyFormField(
                  controller: controller.currencyCtr,
                  initialValue: 0.toStringIDR(),
                  label: International.price.tr,
                  hint: International.price.tr,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => (value.isEmpty)
                      ? controller.currencyCtr.text = 0.toStringIDR()
                      : value,
                  validator: (value) => AppValidator.generalField('$value'),
                  inputFormatters: CustomInputFormatters.idrCurrency,
                  onFieldSubmitted: (value) => Toast.show(value),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
