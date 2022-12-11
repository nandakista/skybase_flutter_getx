import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/converter_helper.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/extension/int_extension.dart';
import 'package:skybase/core/helper/input_formater.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/info_table.dart';
import 'package:skybase/ui/widgets/keyboard_dismisser.dart';
import 'package:skybase/ui/widgets/ordered_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';
import 'package:skybase/ui/widgets/unordered_list.dart';

class OtherUtilsView extends GetView<UtilsController> {
  const OtherUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: SkyAppBar.primary(title: 'Other Utility'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                  'Sample Currency Format = ${controller.currency.currencyFormat()}'),
              const SizedBox(height: 12),
              SkyFormField(
                controller: controller.currencyCtr,
                initialValue: 0.toStringIDR(),
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
              const SizedBox(height: 12),
              Text('Info Table', style: AppStyle.subtitle4),
              const InfoTable(
                data: {
                  'Name': 'Product A',
                  'Weight': '300 gram',
                  'Spec': 'Lorem ipsum sit dorom amet..'
                },
              ),
              const SizedBox(height: 12),
              Text('Unordered List', style: AppStyle.subtitle4),
              const UnorderedList(
                data: {
                  'Name': 'Product A',
                  'Weight': '300 gram',
                  'Spec': 'Lorem ipsum sit dorom amet..'
                },
                captionData: {
                  'Name': 'Some for name',
                  'Spec': 'Some for Spec',
                },
              ),
              const SizedBox(height: 12),
              Text('Ordered List', style: AppStyle.subtitle4),
              OrderedList(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Text('Data $index');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
