import '../models/statistics.dart';
import 'achievement_repository.dart';
import 'daily_target_repository.dart';
import 'reward_repository.dart';

class StatisticsRepository {
  final DailyTargetRepository dailyRepository =
  DailyTargetRepository();

  final AchievementRepository achievementRepository =
  AchievementRepository();

  final RewardRepository rewardRepository =
  RewardRepository();

  Future<Statistics> getStatistics(
      int childId,
      ) async {
    final summary =
    await dailyRepository.getTodaySummary(
      childId,
    );

    final achievements =
    await achievementRepository.getAll(
      childId,
    );

    final totalPoint =
    await rewardRepository.getTotalPoint(
      childId,
    );

    return Statistics(
      totalTarget:
      summary["total"] ?? 0,
      completedTarget:
      summary["selesai"] ?? 0,
      totalAchievement:
      achievements.length,
      totalPoint: totalPoint,
      streak: 0,
    );
  }
}