import '../models/child.dart';
import '../models/daily_target.dart';
import '../repositories/child_repository.dart';
import '../repositories/daily_target_repository.dart';
import 'auto_target_service.dart';

class DailyCycleService {
  final ChildRepository childRepository =
  ChildRepository();

  final DailyTargetRepository dailyRepository =
  DailyTargetRepository();


  final AutoTargetService autoTargetService =
  AutoTargetService();

  Future<bool> isNewDay(
      Child child,
      ) async {
    final lastLearningDate =
    await childRepository.getLastLearningDate(
      child.id!,
    );

    if (lastLearningDate == null) {
      return true;
    }

    final today = DateTime.now();

    return today.year != lastLearningDate.year ||
        today.month != lastLearningDate.month ||
        today.day != lastLearningDate.day;
  }

  Future<void> run(
      Child child,
      ) async {
    final newDay =
    await isNewDay(
      child,
    );

    if (!newDay) {
      return;
    }

    // STEP 1
    // Generate target belajar hari ini.

    final alreadyGenerated =
    await dailyRepository.hasTodayTargets(
      child.id!,
    );

    if (alreadyGenerated) {
      await childRepository.updateLastLearningDate(
        child.id!,
        DateTime.now(),
      );

      return;
    }

    final List<DailyTarget> todayTargets =
    await autoTargetService.generateTodayTargets(
      child,
    );

    // STEP 2
    // Simpan ke tabel daily_target.

    for (final dailyTarget in todayTargets) {
      await dailyRepository.add(
        dailyTarget,
      );
    }

    // STEP 3
    // Simpan tanggal belajar terakhir.

    await childRepository.updateLastLearningDate(
      child.id!,
      DateTime.now(),
    );
  }
}

