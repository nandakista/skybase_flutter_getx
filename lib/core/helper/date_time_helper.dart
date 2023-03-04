import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skybase/core/extension/datetime_extension.dart';
import 'package:skybase/core/localization/locale_helper.dart';

class DateTimeHelper {
  static String parseLocalDate({
    required DateTime? date,
    String? format,
    String? idFormat,
  }) {
    if (date != null) {
      return LocaleHelper.builder(
        enCallback: DateFormat(format).format(date),
        idCallback: DateFormat(idFormat ?? format, 'id').format(date),
      );
    } else {
      return 'Date is null';
    }
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
      return parseLocalDate(date: date, format: 'dd MMM');
    } else {
      return parseLocalDate(date: date, format: 'dd/MM/y');
    }
  }

  static String dateToSentenceInDay({required DateTime date, String? format}) {
    if (date.isToday()) {
      return 'txt_today'.tr;
    } else if (date.isYesterday()) {
      return 'txt_yesterday'.tr;
    } else if (date.isTomorrow()) {
      return 'txt_tomorrow'.tr;
    } else {
      return parseLocalDate(date: date, format: format ?? 'dd MMM');
    }
  }

  static String toLocalizeDay({required String dayName}) {
    if(dayName == 'Sunday') {
      return 'txt_sunday'.tr;
    } else if (dayName == 'Monday') {
      return 'txt_monday'.tr;
    } else if (dayName == 'Tuesday') {
      return 'txt_tuesday'.tr;
    } else if (dayName == 'Wednesday') {
      return 'txt_wednesday'.tr;
    } else if (dayName == 'Thursday') {
      return 'txt_thursday'.tr;
    } else if (dayName == 'Friday') {
      return 'txt_friday'.tr;
    } else if (dayName == 'Saturday'){
      return 'txt_saturday'.tr;
    } else {
      return dayName;
    }
  }
}

