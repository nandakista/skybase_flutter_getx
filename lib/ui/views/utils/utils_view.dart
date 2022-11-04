import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/helper/converter_helper.dart';
import 'package:skybase/core/helper/extension/int_extension.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/views/utils/utils_view_2.dart';
import 'package:skybase/ui/widgets/date_picker_widget.dart';
import 'package:skybase/core/helper/date_time_helper.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/input_formater.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/modules/module_helper.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/theme_manager.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/image_picker.dart';
import 'package:skybase/ui/widgets/sky_box.dart';
import 'package:skybase/ui/widgets/sky_image.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class UtilsView extends GetView<UtilsController> {
  const UtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Utils 1'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentWrapper(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkyButton(
                  text: 'Page 2',
                  icon: Icons.ac_unit,
                  outlineMode: true,
                  onPressed: () => Get.to(const UtilsView2()),
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
                ..._buildImagePicker(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildImagePicker(BuildContext context) => [
        UiImagePicker(
          onSelected: (file) {
            print('file = $file');
          },
          child: SkyBox(child: Text('Test'),
          ),
        ),
        const Text('Module Camera'),
        Obx(
          () => Container(
            child: controller.imageFile.value != null
                ? SkyImage(
                    url: controller.imageFile.value!.path,
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SkyImage(url: 'assets/images/img_man.png'),
                      ),
                    ),
                  ),
          ),
        ),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              ModuleHelper.pickImage(showInfo: true).then((img) {
                if (img != null) {
                  controller.imageFile.value = img;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 100,
              child: Column(
                children: [
                  const Icon(
                    Icons.add_a_photo_outlined,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  Text(International.camera.tr)
                ],
              ),
            ),
          ),
        )
      ];
}
