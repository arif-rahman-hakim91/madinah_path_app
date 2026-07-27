import 'daily_target.dart';
import 'target.dart';

class HistoryItem {
  final DailyTarget dailyTarget;

  final Target target;

  const HistoryItem({
    required this.dailyTarget,
    required this.target,
  });
}