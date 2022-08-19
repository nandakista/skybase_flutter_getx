import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/helper/converter_helper.dart';
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
import 'package:skybase/ui/widgets/basic_widget.dart';
import 'package:skybase/ui/widgets/custom_button.dart';
import 'package:skybase/ui/widgets/custom_form_field.dart';

class UtilsView extends StatefulWidget {
  const UtilsView({Key? key}) : super(key: key);

  @override
  State<UtilsView> createState() => _UtilsViewState();
}

class _UtilsViewState extends State<UtilsView> {
  File? _imageFile;
  final currencyCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentWrapper(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                CustomButton(
                  onPressed: () => LocaleHelper().showLocaleDialog(context),
                  text: International.changeLanguage.tr,
                  icon: CupertinoIcons.paintbrush,
                ),
                CustomButton(
                  onPressed: () {
                    AppDialog.show(
                      typeDialog: TypeDialog.FAILED,
                      message: 'Dialog',
                      onPress: () => AppDialog.close(),
                    );
                  },
                  text: 'Dialog',
                  icon: CupertinoIcons.conversation_bubble,
                ),
                CustomButton(
                  onPressed: () {
                    Loading.show(dismissible: true);
                  },
                  text: 'Loading',
                  icon: CupertinoIcons.refresh_thick,
                ),
                CustomButton(
                  onPressed: () {
                    String? converted = DateTimeHelper(
                            startDate: DateTime.now(), endDate: DateTime.now())
                        .format();
                    Toast.show('Date converted :\n $converted');
                  },
                  text: International.convert.tr + ' ' + International.date.tr,
                ),
                CustomButton(
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
                CustomButton(
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
                CustomFieldForm(
                  controller: currencyCtr,
                  initialValue: 0.toIDR(),
                  label: International.price.tr,
                  hint: International.price.tr,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      (value.isEmpty) ? currencyCtr.text = 0.toIDR() : value,
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
        const Text('Module Camera'),
        Container(
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  height: MediaQuery.of(context).size.width * 1 / 2,
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  fit: BoxFit.contain,
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
                      child: Image(
                        image: AssetImage('assets/images/img_man.png'),
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
                  setState(() => _imageFile = img);
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
