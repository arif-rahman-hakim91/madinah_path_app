import '../models/daily_target.dart';

class HistoryStatisticsService {
  int totalLearningDays(
      List<DateTime> dates,
      ) {
    return dates.length;
  }

  int totalCompleted(
      List<DailyTarget> targets,
      ) {
    return targets
        .where(
          (e) => e.isCompleted,
    )
        .length;
  }

  int totalUncompleted(
      List<DailyTarget> targets,
      ) {
    return targets
        .where(
          (e) => !e.isCompleted,
    )
        .length;
  }

  double completionRate(
      List<DailyTarget> targets,
      ) {
    if (targets.isEmpty) {
      return 0;
    }

    return totalCompleted(targets) /
        targets.length;
  }
}