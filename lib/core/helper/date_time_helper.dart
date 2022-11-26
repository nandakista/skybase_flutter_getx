import 'package:intl/intl.dart';
import 'package:skybase/core/helper/extension/datetime_extension.dart';

class DateTimeHelper {
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

