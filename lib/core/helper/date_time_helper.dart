import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skybase/core/helper/extension/datetime_extension.dart';

import 'locale_callback.dart';

class DateTimeHelper {
  static String parseLocalDate({
    required DateTime date,
    String? format,
    String? idFormat,
  }) {
    return LocaleCallback.builder(
      enCallback: DateFormat(format).format(date),
      idCallback: DateFormat(idFormat ?? format, 'id_ID').format(date),
    );
  }

  static String dateToSentence(DateTime date) {
    if (date.inThisHours()) {
      int intDateTime = date.difference(DateTime.now()).inMinutes;
      if (intDateTime <= 0) {
        return 'txt_expired'.tr;
      } else {
        return '$intDateTime ${'txt_minutes'.tr}';
      }
    } else if (date.isToday()) {
      return '${date.difference(DateTime.now()).inHours} ${'txt_hours'.tr}';
    } else if (date.inNextWeek()) {
      return '${date.difference(DateTime.now()).inDays + 1} ${'txt_days'.tr}';
    } else if (date.inThisYear()) {
      return LocaleCallback.builder<String>(
        enCallback: DateFormat('dd MMM').format(date),
        idCallback: DateFormat('dd MMM', 'id_ID').format(date),
      );
    } else {
      return LocaleCallback.builder<String>(
        enCallback: DateFormat('dd/MM/y').format(date),
        idCallback: DateFormat('dd/MM/y', 'id_ID').format(date),
      );
    }
  }
}

