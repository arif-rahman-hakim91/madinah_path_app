import '../models/statistics.dart';

class StatisticsEngine {
  const StatisticsEngine();

  String learningLevel(
      Statistics statistics,
      ) {
    final percent =
        statistics.progressPercent;

    if (percent >= 90) {
      return "Sangat Baik";
    }

    if (percent >= 70) {
      return "Baik";
    }

    if (percent >= 50) {
      return "Cukup";
    }

    return "Perlu Ditingkatkan";
  }

  bool isExcellent(
      Statistics statistics,
      ) {
    return statistics.progressPercent >= 90;
  }

  bool hasAchievement(
      Statistics statistics,
      ) {
    return statistics.totalAchievement > 0;
  }

  bool hasReward(
      Statistics statistics,
      ) {
    return statistics.totalPoint > 0;
  }
}