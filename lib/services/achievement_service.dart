import '../models/achievement.dart';
import '../repositories/achievement_repository.dart';
import 'current_child_service.dart';

class AchievementService {
  final repository = AchievementRepository();

  Future<void> unlock({
    required String title,
    required String description,
    required String icon,
  }) async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return;
    }

    final alreadyUnlocked = await repository.exists(
      child.id!,
      title,
    );

    if (alreadyUnlocked) {
      return;
    }

    await repository.add(
      Achievement(
        childId: child.id!,
        title: title,
        description: description,
        icon: icon,
        unlockedAt: DateTime.now(),
      ),
    );
  }

  Future<List<Achievement>> getAll() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return [];
    }

    return repository.getAll(child.id!);
  }
}