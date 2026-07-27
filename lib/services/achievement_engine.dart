import '../models/target.dart';
import 'achievement_service.dart';

class AchievementEngine {
  final AchievementService service =
  AchievementService();

  Future<void> evaluate({
    required List<Target> targets,
  }) async {
    final completed = targets
        .where(
          (target) => target.isCompleted,
    )
        .length;

    if (completed >= 1) {
      await service.unlock(
        title: "Langkah Pertama",
        description:
        "Menyelesaikan target pertama.",
        icon: "emoji_events",
      );
    }

    if (completed >= 10) {
      await service.unlock(
        title: "Semangat Belajar",
        description:
        "Menyelesaikan 10 target.",
        icon: "military_tech",
      );
    }

    if (completed >= 50) {
      await service.unlock(
        title: "Pejuang Ilmu",
        description:
        "Menyelesaikan 50 target.",
        icon: "workspace_premium",
      );
    }
  }
}