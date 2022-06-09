import 'package:flutter/services.dart';

class CustomInputFormatters {
  static List<TextInputFormatter>? numberWith2Decimals = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\,?\d{0,2}')),
    TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
        text: newValue.text.replaceAll(',', '.'),
      ),
    ),
  ];
}
