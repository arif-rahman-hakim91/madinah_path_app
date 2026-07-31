import '../models/guardian.dart';
import '../repositories/guardian_repository.dart';

import '../models/dashboard_data.dart';
import '../services/dashboard_service.dart';

import '../repositories/daily_target_repository.dart';
import '../services/current_child_service.dart';

import '../services/learning_engine.dart';
import '../services/learning_flow_service.dart';
import '../services/smart_resume_service.dart';
import 'load_today_targets_result.dart';

class DashboardController {
  final GuardianRepository guardianRepository =
  GuardianRepository();

  final DashboardService dashboardService =
  DashboardService();

  final DailyTargetRepository dailyTargetRepository =
  DailyTargetRepository();

  final LearningEngine learningEngine =
  LearningEngine();

  final LearningFlowService learningFlowService =
  LearningFlowService();

  final SmartResumeService smartResumeService =
  SmartResumeService();

  Future<Guardian?> loadGuardian() async {
    return await guardianRepository.getGuardian();
  }

  Future<DashboardData> loadDashboard() async {
    return await dashboardService.loadDashboard();
  }

  Future<Map<String, int>> loadTargetSummary() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return {
        "total": 0,
        "selesai": 0,
      };
    }

    final summary = await dailyTargetRepository.getTodaySummary(
      child.id!,
    );

    return {
      "total": summary["total"] ?? 0,
      "selesai": summary["selesai"] ?? 0,
    };
  }

  Future<LoadTodayTargetsResult> loadTodayTargets() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return const LoadTodayTargetsResult(
        todayTargets: [],
        learningFlow: [],
        learningMessage: "",
        smartResume: "",
      );
    }

    final result =
    await learningEngine.getTodayTargets(child);

    final flow =
    learningFlowService.generateFlow(result);

    return LoadTodayTargetsResult(
      todayTargets: result,
      learningFlow: flow,
      learningMessage:
      learningEngine.getGreetingMessage(flow),
      smartResume:
      smartResumeService.generateSummary(result),
    );
  }
}