import '../models/reward.dart';
import '../repositories/reward_repository.dart';
import 'current_child_service.dart';

class RewardService {
  final RewardRepository repository =
  RewardRepository();

  Future<void> addPoint({
    required int point,
    required String title,
    required String description,
  }) async {
    final child =
        CurrentChildService.currentChild;

    if (child == null) {
      return;
    }

    await repository.add(
      Reward(
        childId: child.id!,
        point: point,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<Reward>> getAll() async {
    final child =
        CurrentChildService.currentChild;

    if (child == null) {
      return [];
    }

    return repository.getAll(
      child.id!,
    );
  }

  Future<int> getTotalPoint() async {
    final child =
        CurrentChildService.currentChild;

    if (child == null) {
      return 0;
    }

    return repository.getTotalPoint(
      child.id!,
    );
  }
}