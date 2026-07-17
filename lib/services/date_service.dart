class DateService {
  const DateService();

  DateTime get today {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  String get todayString {
    final date = today;

    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  DateTime daysAgo(int days) {
    return today.subtract(
      Duration(days: days),
    );
  }

  DateTime daysAfter(int days) {
    return today.add(
      Duration(days: days),
    );
  }

  bool isSameDay(
      DateTime first,
      DateTime second,
      ) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}