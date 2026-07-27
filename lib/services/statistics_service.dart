import '../models/statistics.dart';
import '../repositories/statistics_repository.dart';
import 'current_child_service.dart';

class StatisticsService {
  final StatisticsRepository repository =
  StatisticsRepository();

  Future<Statistics?> getStatistics() async {
    final child =
        CurrentChildService.currentChild;

    if (child == null) {
      return null;
    }

    return repository.getStatistics(
      child.id!,
    );
  }
}