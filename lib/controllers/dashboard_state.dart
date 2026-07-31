import '../models/dashboard_data.dart';
import '../models/guardian.dart';
import '../models/target.dart';

class DashboardState {
  final Guardian? guardian;

  final DashboardData dashboardData;

  final List<Target> todayTargets;

  final List<Target> learningFlow;

  final String learningMessage;

  final String smartResume;

  final int totalTargetHariIni;

  final int targetSelesaiHariIni;

  const DashboardState({
    required this.guardian,
    required this.dashboardData,
    required this.todayTargets,
    required this.learningFlow,
    required this.learningMessage,
    required this.smartResume,
    required this.totalTargetHariIni,
    required this.targetSelesaiHariIni,
  });

  factory DashboardState.empty() {
    return const DashboardState(
      guardian: null,
      dashboardData: DashboardData(
        progress: 0,
        hafalanCount: 0,
        ibadahCount: 0,
        strength: "",
        improvement: "",
        weeklyProgress: [],
      ),
      todayTargets: [],
      learningFlow: [],
      learningMessage: "",
      smartResume: "",
      totalTargetHariIni: 0,
      targetSelesaiHariIni: 0,
    );
  }

  DashboardState copyWith({
    Guardian? guardian,
    DashboardData? dashboardData,
    List<Target>? todayTargets,
    List<Target>? learningFlow,
    String? learningMessage,
    String? smartResume,
    int? totalTargetHariIni,
    int? targetSelesaiHariIni,
  }) {
    return DashboardState(
      guardian: guardian ?? this.guardian,
      dashboardData: dashboardData ?? this.dashboardData,
      todayTargets: todayTargets ?? this.todayTargets,
      learningFlow: learningFlow ?? this.learningFlow,
      learningMessage: learningMessage ?? this.learningMessage,
      smartResume: smartResume ?? this.smartResume,
      totalTargetHariIni:
      totalTargetHariIni ?? this.totalTargetHariIni,
      targetSelesaiHariIni:
      targetSelesaiHariIni ?? this.targetSelesaiHariIni,
    );
  }
}