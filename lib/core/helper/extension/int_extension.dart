import 'package:intl/intl.dart';

extension IntExtension on int {
  /// Convert int to currency format.
  /// * Example : 1000 (int) --> Rp 1.000 (String)
  String toStringIDR() {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(this);
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
}
