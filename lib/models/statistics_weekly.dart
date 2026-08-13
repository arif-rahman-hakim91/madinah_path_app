class StatisticsWeekly {
  final String hari;
  final int total;
  final int selesai;

  const StatisticsWeekly({
    required this.hari,
    required this.total,
    required this.selesai,
  });

  double get progress {
    if (total == 0) {
      return 0;
    }

    return selesai / total;
  }

  int get progressPercent {
    return (progress * 100).round();
  }
}