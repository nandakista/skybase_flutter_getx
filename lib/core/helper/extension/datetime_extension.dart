extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool inThisWeek() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return isAfter(weekAgo);
  }

  bool inThisYear() {
    final yearAgo = DateTime.now().subtract(const Duration(days: 365));
    return isAfter(yearAgo);
  }
}