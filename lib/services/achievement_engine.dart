import '../core/constants/achievement_rules.dart';
import '../models/target.dart';
import 'achievement_service.dart';

class AchievementEngine {
  final AchievementService service = AchievementService();

  Future<void> evaluate({
    required List<Target> targets,
  }) async {
    final completed = targets
        .where((target) => target.isCompleted)
        .length;

    for (final rule in achievementRules) {
      if (completed >= rule.requiredValue) {
        await service.unlock(
          title: rule.title,
          description: rule.description,
          icon: rule.icon,
        );
      }
    }
  }
}