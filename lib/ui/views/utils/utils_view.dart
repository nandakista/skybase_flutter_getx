import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/date_time_helper.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/core/localization/language_const.dart';
import 'package:varcore_flutter_base/core/localization/locale_helper.dart';
import 'package:varcore_flutter_base/core/modules/module_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/theme_manager.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';

class UtilsView extends StatefulWidget {
  const UtilsView({Key? key}) : super(key: key);

  @override
  State<UtilsView> createState() => _UtilsViewState();
}

class _UtilsViewState extends State<UtilsView> {
  File? _imageFile;

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
                  icon: CupertinoIcons.squares_below_rectangle,
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
                    String? converted = DateHelper(startDate: DateTime.now(), endDate: DateTime.now()).format();
                    Toast.show('Date converted :\n $converted');
                  },
                  text: International.convert.tr + ' ' + International.date.tr,
                  icon: Icons.date_range_outlined,
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
        width: MediaQuery.of(context).size.width * 2/3,
        fit: BoxFit.contain,
      )
          : SizedBox(
        height: MediaQuery.of(context).size.width * 1 / 2,
        width: MediaQuery.of(context).size.width * 1/2,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(40.0),
            child: Image(
              image: AssetImage('assets/img_man.png'),
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
              setState(()=> _imageFile = img);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 100,
          child: Column(
            children: const [
              Icon(
                Icons.add_a_photo_outlined,
                size: 30,
                color: AppColors.primary,
              ),
              Text(
                'Kamera',
              )
            ],
          ),
        ),
      ),
    )
  ];
}
