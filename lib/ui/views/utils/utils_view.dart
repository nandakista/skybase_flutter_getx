import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/core/localization/lang_const.dart';
import 'package:varcore_flutter_base/core/localization/locale_helper.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';

class UtilsView extends StatelessWidget {
  const UtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContentWrapper(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () => LocaleHelper().showLocaleDialog(context),
                text: MultiLangs.changeLanguage.tr,
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
            ],
          ),
        ),
      ),
    );
  }
}
