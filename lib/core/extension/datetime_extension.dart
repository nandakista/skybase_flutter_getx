extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool inThisHours() {
    final now = DateTime.now();
    return now.hour == hour &&
        now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isTomorrow() {
    final yesterday = DateTime.now().add(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool inNextWeek() {
    final weekAgo = DateTime.now().add(const Duration(days: 7));
    return isBefore(weekAgo) && isAfter(DateTime.now());
  }

  bool inThisMonth() {
    return month == DateTime.now().month;
  }

  bool inThisYear() {
    return year == DateTime.now().year;
  }

  bool inLastWeek() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return isAfter(weekAgo);
  }

  bool inLastYear() {
    final yearAgo = DateTime.now().subtract(const Duration(days: 365));
    return isAfter(yearAgo);
  }
}