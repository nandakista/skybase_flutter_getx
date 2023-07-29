import 'package:intl/intl.dart';

extension IntExtension on int {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    int number = this;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }

  String stringDateFromMillisecondInApproach({
    String pattern = "dd MMMM yyyy",
  }) {
    DateTime dateTime = dateTimeFromMillisecondInApproach();
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  DateTime dateTimeFromMillisecondInApproach() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

extension IntNullExtension on int? {
  String currencyFormat({
    String symbol = 'Rp. ',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    int number = this ?? 0;
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
