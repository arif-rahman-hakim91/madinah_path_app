import '../models/target.dart';

class LoadTodayTargetsResult {
  final List<Target> todayTargets;
  final List<Target> learningFlow;
  final String learningMessage;
  final String smartResume;

  const LoadTodayTargetsResult({
    required this.todayTargets,
    required this.learningFlow,
    required this.learningMessage,
    required this.smartResume,
  });
}