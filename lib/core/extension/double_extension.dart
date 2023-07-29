import 'package:intl/intl.dart';

extension IntNullExtension on double? {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    double? number = this ?? 0;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }

  String get toSoldFormat {
    if(this != null) {
      if(this!>1000) {
        return '${(this!/1000).toStringAsFixed(2)}K';
      } else {
        return this!.toString();
      }
    } else {
      return 0.toString();
    }
  }
}

extension IntExtension on double {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(this);
  }
}