import '../models/history_item.dart';
import '../repositories/daily_target_repository.dart';
import '../repositories/target_repository.dart';

class HistoryRepository {
  final DailyTargetRepository dailyRepository =
  DailyTargetRepository();

  final TargetRepository targetRepository =
  TargetRepository();

  Future<List<HistoryItem>> getHistoryByDate(
      int childId,
      DateTime date,
      ) async {
    final dailyTargets =
    await dailyRepository.getHistoryByDate(
      childId,
      date,
    );

    final List<HistoryItem> history = [];

    for (final dailyTarget in dailyTargets) {
      final target =
      await targetRepository.getById(
        dailyTarget.targetId,
      );

      if (target == null) {
        continue;
      }

      history.add(
        HistoryItem(
          dailyTarget: dailyTarget,
          target: target,
        ),
      );
    }

    return history;
  }
}