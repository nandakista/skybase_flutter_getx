import 'package:intl/intl.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_key.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_manager.dart';

/// If you want to convert 1 date, just fill [date].
/// If you want to convert range date, you can fill [startDate], [endDate]
/// * Example : DateHelper(startDate: x, endDate: y).format2()
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
    String locale = GetStorageManager.to.get(GetStorageKey.CURRENT_LOCALE);

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
}
