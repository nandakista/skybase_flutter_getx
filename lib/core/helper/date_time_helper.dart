import 'package:intl/intl.dart';
import 'package:skybase/config/localization/locale_helper.dart';

class DateTimeHelper {
  static String parseLocalDate({
    required DateTime? date,
    String? format,
    String? idFormat,
  }) {
    if (date != null) {
      return LocaleHelper.builder(
        en: DateFormat(format).format(date),
        id: DateFormat(idFormat ?? format, 'id').format(date),
      );
    } else {
      return 'Date is null';
    }
  }
}

