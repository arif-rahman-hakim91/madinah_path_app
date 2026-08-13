import '../models/statistics.dart';
import '../models/statistics_weekly.dart';
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

  Future<List<StatisticsWeekly>> getWeeklyStatistics(
      int childId,
      ) async {
    final dailyTargets =
    await dailyRepository.getLast7Days(
      childId,
    );

    final Map<String, List<dynamic>> grouped = {};

    const hari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Ahad",
    ];

    for (final namaHari in hari) {
      grouped[namaHari] = [];
    }

    for (final dailyTarget in dailyTargets) {
      final weekday = dailyTarget.tanggal.weekday;

      final namaHari = hari[weekday - 1];

      grouped[namaHari]!.add(
        dailyTarget,
      );
    }

    return hari.map((namaHari) {
      final targets = grouped[namaHari]!;

      final total = targets.length;

      final selesai = targets
          .where(
            (target) => target.isCompleted,
      )
          .length;

      return StatisticsWeekly(
        hari: namaHari,
        total: total,
        selesai: selesai,
      );
    }).toList();
  }

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