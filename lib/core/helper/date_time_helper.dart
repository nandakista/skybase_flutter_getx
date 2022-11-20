import 'package:intl/intl.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/helper/extension/datetime_extension.dart';

/// If you want to convert 1 date, just fill [date].
/// If you want to convert range date, you can fill [startDate], [endDate]
/// * Example : DateHelper(startDate: x, endDate: y).format2()
class DateTimeHelper {

  DateTime? date;
  DateTime? startDate;
  DateTime? endDate;

  DateTimeHelper({
    this.date,
    this.startDate,
    this.endDate
  });

  String? format() {
    return formatDate(pattern: 'dd MM yyyy - HH:mm:ss');
  }

  String? format2() {
    return formatDate(pattern: 'dd MM yyyy');
  }

  String? format3() {
    return formatDate(pattern: 'dd-MM-yyyy');
  }

  String? format4() {
    return formatDate(pattern: 'EEEE, dd MM y');
  }

  String? format5() {
    return formatDate(pattern: 'EEEE, dd MMMM yyyy HH:mm');
  }

  String? formatDays() {
    return formatDate(pattern: 'dd');
  }

  String? formatHours() {
    return formatDate(pattern: 'HH:mm');
  }

  String? formatDate({String? pattern}) {
    bool isRange = (startDate != null && endDate != null);
    bool isNotRange = (startDate == null && endDate == null);
    String locale = GetStorageManager.find.get(GetStorageKey.currentLocale);

    if(isRange && date == null) {
      var start = DateFormat(pattern, locale).format(startDate!);
      var end = DateFormat(pattern, locale).format(endDate!);
      return '$start - $end';
    } else if (date != null && isNotRange) {
      return DateFormat(pattern, locale).format(date!);
    } else {
      return 'Error date converted!';
    }
  }

  static String dateToSentence(DateTime date) {
    if (date.inThisHours()) {
      int intDateTime = date.difference(DateTime.now()).inMinutes;
      if (intDateTime <= 0) {
        return 'Expired';
      } else {
        return intDateTime.toString() + ' minutes';
      }
    } else if (date.isToday()) {
      return date.difference(DateTime.now()).inHours.toString() + ' hours';
    } else if (date.inNextWeek()) {
      return (date.difference(DateTime.now()).inDays + 1).toString() + ' days';
    } else if (date.inThisYear()) {
      return DateFormat('dd MMM').format(date);
    } else {
      return DateFormat('dd/MM/y').format(date);
    }
  }
}

