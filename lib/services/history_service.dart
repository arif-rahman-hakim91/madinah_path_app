import '../models/history_item.dart';
import '../repositories/daily_target_repository.dart';
import '../repositories/history_repository.dart';

class HistoryService {
  final HistoryRepository repository =
  HistoryRepository();

  final DailyTargetRepository dailyRepository =
  DailyTargetRepository();

  Future<List<DateTime>> getLearningDates(
      int childId,
      ) async {
    return await dailyRepository.getLearningDates(
      childId,
    );
  }

  Future<List<HistoryItem>> getHistoryByDate(
      int childId,
      DateTime date,
      ) async {
    return await repository.getHistoryByDate(
      childId,
      date,
    );
  }

  Future<int> countLearningDays(
      int childId,
      ) async {
    final dates =
    await getLearningDates(childId);

    return dates.length;
  }
}