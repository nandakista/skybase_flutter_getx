import 'package:intl/intl.dart';

const String dateFormat = 'y-MM-dd';
const String dateFormatName = 'd MMM y';
const String FORMAT_LONG_DAY_MONTH_TIME = 'EEEE, dd MMMM yyyy HH:mm:ss';
const String FORMAT_LONG_DAY_AND_MONTH = 'EEEE, dd MMMM yyyy';
const String FORMAT_DD_MMM_YYYY = 'dd MMM yyyy';
const String FORMAT_EEE_DD_MMM_YYYY = 'EEE, dd MMM yyyy';
const String FORMAT_DEFAULT = 'yyyy-MM-dd HH:mm:ss';

class DateHelper {

  DateTime? date;
  DateTime? startDate;
  DateTime? endDate;

  DateHelper({
    this.date,
    this.startDate,
    this.endDate
  });

  String? format() {
    return formatDate(pattern: 'dd MMMM y');
  }

  String? format2() {
    return formatDate(pattern: 'dd/MM/yyyy');
  }

  String? format3() {
    return formatDate(pattern: 'dd-MM-yyyy');
  }

  String? format4() {
    return formatDate(pattern: 'EEEE, dd MMMM y');
  }

  String? format5() {
    return formatDate(pattern: 'EEEE, dd MMMM yyyy HH:mm:ss');
  }

  String? format6() {
    return formatDate(pattern: 'yyyy-MM-dd');
  }

  String? formatDate({String? pattern}) {
    bool isRange = (startDate != null && endDate != null);
    bool isNotRange = (startDate == null && endDate == null);

    if(isRange && date == null) {
      var start = DateFormat(pattern).format(startDate!);
      var end = DateFormat(pattern).format(endDate!);
      return '$start - $end';
    } else if (date != null && isNotRange) {
      return DateFormat(pattern).format(date!);
    } else {
      return 'Error date converted!';
    }
  }
}
