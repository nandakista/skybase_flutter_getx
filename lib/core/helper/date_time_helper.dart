import 'package:intl/intl.dart';

const String dateFormat = "y-MM-dd";
const String dateFormatName = "d MMM y";
const String FORMAT_LONG_DAY_MONTH_TIME = "EEEE, dd MMMM yyyy HH:mm:ss";
const String FORMAT_LONG_DAY_AND_MONTH = "EEEE, dd MMMM yyyy";
const String FORMAT_DD_MMM_YYYY = "dd MMM yyyy";
const String FORMAT_EEE_DD_MMM_YYYY = "EEE, dd MMM yyyy";
const String FORMAT_DEFAULT = "yyyy-MM-dd HH:mm:ss";

class DateHelper {

  DateTime? date;
  DateTime? startDate;
  DateTime? endDate;

  DateHelper({
    this.date,
    this.startDate,
    this.endDate
  });

  String? format({bool range = false}) {
    return formatDate(range: range, pattern: 'dd MMMM y');
  }

  String? format2({bool range = false}) {
    return formatDate(range: range, pattern: 'dd/MM/yyyy');
  }

  String? format3({bool range = false}) {
    return formatDate(range: range, pattern: 'dd-MM-yyyy');
  }

  String? format4({bool range = false}) {
    return formatDate(range: range, pattern: 'EEEE, dd MMMM y');
  }

  String? format5({bool range = false}) {
    return formatDate(range: range, pattern: 'EEEE, dd MMMM yyyy HH:mm:ss');
  }

  String? format6({bool range = false}) {
    return formatDate(range: range, pattern: 'yyyy-MM-dd');
  }

  String? formatDate({bool range = false, String? pattern}) {
    if(range) {
      if(startDate == null || endDate == null) return null;
      var start = DateFormat(pattern).format(startDate!);
      var end = DateFormat(pattern).format(endDate!);
      return '$start - $end';
    } else {
      if(date == null) return null;
      return DateFormat(pattern).format(date!);
    }
  }

}
