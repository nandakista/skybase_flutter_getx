import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skybase/core/helper/converter_helper.dart';
import 'package:skybase/core/extension/num_extension.dart';
import 'package:skybase/core/helper/input_formater.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/keyboard_dismissible.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class OtherUtilsView extends GetView<UtilsController> {
  const OtherUtilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
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
                initialValue: 0.currencyFormat(symbol: 'Rp'),
                hint: 'txt_price'.tr,
                keyboardType: TextInputType.number,
                onChanged: (value) => (value.isEmpty)
                    ? controller.currencyCtr.text =
                        0.currencyFormat(symbol: 'Rp')
                    : value,
                validator: (value) => ValidatorHelper.required('$value'),
                inputFormatters: CustomInputFormatters.idrCurrency,
                onFieldSubmitted: (value) => SnackBarHelper.normal(message: value),
              ),
              const SizedBox(height: 12),
              SkyButton(
                onPressed: () {
                  String? converted = ConverterHelper.replaceStringRange(
                      'name@email.com', 2, 5, '*');
                  debugPrint('Converted = $converted');
                  SnackBarHelper.normal(message: 'String converted :\n $converted');
                },
                text: 'Convert String',
                icon: CupertinoIcons.t_bubble,
              ),
              const SizedBox(height: 26),
              Text('Date', style: AppStyle.subtitle4),
              const SizedBox(height: 12),
              const Text('Date Sample Converter'),
              Text(DateFormat('dd MMMM yyy').format(DateTime.now())),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
