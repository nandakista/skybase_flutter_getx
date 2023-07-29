extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get inThisHours {
    final now = DateTime.now();
    return now.hour == hour &&
        now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool get isTomorrow {
    final yesterday = DateTime.now().add(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get inNextWeek {
    final weekAgo = DateTime.now().add(const Duration(days: 7));
    return isBefore(weekAgo) && isAfter(DateTime.now());
  }

  bool get inThisMonth {
    return month == DateTime.now().month;
  }

  bool get inThisYear {
    return year == DateTime.now().year;
  }

  bool get inLastWeek {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return isAfter(weekAgo);
  }

  bool get inLastYear {
    final yearAgo = DateTime.now().subtract(const Duration(days: 365));
    return isAfter(yearAgo);
  }
}