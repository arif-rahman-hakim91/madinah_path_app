import 'package:flutter/material.dart';

// Models
import '../models/guardian.dart';
import '../models/target.dart';

// Repositories
import '../repositories/guardian_repository.dart';
import '../repositories/daily_target_repository.dart';
import '../repositories/target_repository.dart';

// Services
import '../services/current_child_service.dart';
import '../services/dashboard_service.dart';
import '../services/learning_engine.dart';
import '../services/learning_flow_service.dart';
import '../services/smart_resume_service.dart';
import '../services/achievement_engine.dart';
import '../services/point_engine.dart';

// Widgets
import '../widgets/active_child_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/navigation_card.dart';
import '../widgets/profile_guardian_card.dart';
import '../widgets/strength_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/target_list_card.dart';
import '../widgets/weekly_consistency_card.dart';
import '../widgets/smart_resume_card.dart';
import '../widgets/target_today_card.dart';
import '../widgets/common/app_card.dart';

import '../widgets/common/app_loading.dart';
import '../widgets/evaluation_bottom_sheet.dart';

// Screens
import 'child_selector_screen.dart';
import 'guardian_screen.dart';

import 'ibadah_screen.dart';

import 'target_screen.dart';
import 'history_screen.dart';
import 'achievement_screen.dart';
import 'reward_screen.dart';
import 'statistics_screen.dart';

//core
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dashboardService = DashboardService();
  final guardianRepository = GuardianRepository();
  final targetRepository = TargetRepository();
  final dailyTargetRepository = DailyTargetRepository();

  final LearningEngine learningEngine = LearningEngine();

  final LearningFlowService learningFlowService =
  LearningFlowService();

  final SmartResumeService smartResumeService =
  SmartResumeService();

  final AchievementEngine achievementEngine =
  AchievementEngine();

  final PointEngine pointEngine =
  PointEngine();

  List<Target> learningFlow = [];

  String learningMessage = "";

  LearningRecommendation? recommendation;

  String smartResume = "";

  Guardian? guardian;

  double progress = 0;

  int ibadahCount = 0;

  int hafalanCount = 0;

  int totalTargetHariIni = 0;

  int targetSelesaiHariIni = 0;

  String strength = "";

  String improvement = "";

  List<double> weeklyProgress = [];

  List<Target> todayTargets = [];

  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    refreshDashboard();
  }


  Future<void> loadTargetSummary() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final summary =
    await dailyTargetRepository.getTodaySummary(
      child.id!,
    );

    if (!mounted) return;

    setState(() {
      totalTargetHariIni =
          summary["total"] ?? 0;

      targetSelesaiHariIni =
          summary["selesai"] ?? 0;
    });
  }

  Future<void> loadTodayTargets() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final result =
    await learningEngine.getTodayTargets(
      child,
    );

    final flow =
    learningFlowService.generateFlow(
      result,
    );

    setState(() {
      todayTargets = result;

      learningFlow = flow;

      learningMessage =
          learningEngine.getGreetingMessage(
            flow,
          );

      recommendation =
          learningEngine.generateRecommendation(
            flow,
          );

      smartResume =
          smartResumeService.generateSummary(
            result,
          );
    });
  }
  Future<void> refreshDashboard() async {

    setState(() {
      isLoading = true;
    });

    await loadGuardian();
    await loadProgress();
    await loadTargetSummary();
    await loadTodayTargets();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> evaluateTarget(
      Target target,
      String status,
      ) async {
    await targetRepository.updateStatus(
      target: target,
      status: status,
    );

    final child = CurrentChildService.currentChild;

    if (child != null) {
      final todayTargets =
      await dailyTargetRepository.getTodayTargets(
        child.id!,
      );

      final dailyTarget = todayTargets.firstWhere(
            (item) => item.targetId == target.id,
      );

      await dailyTargetRepository.updateCompletion(
        dailyTargetId: dailyTarget.id!,
        isCompleted: true,
      );
    }

    await achievementEngine.evaluate(
      targets: await learningEngine.getTodayTargets(
        child!,
      ),
    );

    await pointEngine.givePoint(
      status,
    );

    await refreshDashboard();

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }


  Future<void> loadProgress() async {
    final dashboard =
    await dashboardService.loadDashboard();

    if (!mounted) return;

    setState(() {
      progress = dashboard.progress;

      ibadahCount = dashboard.ibadahCount;

      hafalanCount = dashboard.hafalanCount;

      strength = dashboard.strength;

      improvement = dashboard.improvement;

      weeklyProgress =
          dashboard.weeklyProgress;
    });
  }

  Future<void> loadGuardian() async {
    final data =
    await guardianRepository.getGuardian();

    if (!mounted) return;

    setState(() {
      guardian = data;
    });
  }

  Future<void> pilihAnak() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const ChildSelectorScreen(),
      ),
    );

    if (result == true) {
      await refreshDashboard();

      if (!mounted) return;
    }
  }

  Future<void> openScreen(Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );

    if (!mounted) return;

    await refreshDashboard();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Madinah Path",
          style: AppTextStyle.title,
        ),
        centerTitle: true,
      ),

        body: isLoading
            ? const AppLoading()
            : RefreshIndicator(
          onRefresh: refreshDashboard,
          child: ListView(
            padding: AppSpacing.page,
            children: [
              AppSpacing.verticalMd,

          GreetingHeader(
            guardian: guardian,
          ),

              AppSpacing.verticalLg,

          ActiveChildCard(
            onChangeChild: pilihAnak,
          ),

              AppSpacing.verticalMd,

          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  TargetTodayCard(
                    totalTargetHariIni:
                    totalTargetHariIni,
                    targetSelesaiHariIni:
                    targetSelesaiHariIni,
                    learningMessage:
                    learningMessage,
                  ),

                  TargetListCard(
                    learningFlow:
                    learningFlow,
                    onTap: (target) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (_) {
                          return EvaluationBottomSheet(
                            target: target,
                            onEvaluate: (status) {
                              evaluateTarget(
                                target,
                                status,
                              );
                            },
                          );
                        },
                      );
                    },
                    onAddTarget: () async {
                      final result =
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const TargetScreen(),
                        ),
                      );

                      if (result == true) {
                        await refreshDashboard();

                        if (!mounted) {
                          return;
                        }
                      }
                    },
                  ),

                  const SizedBox(
                      height: 20),
                ],
              ),
          ),

              AppSpacing.verticalMd,

          SummaryCard(
            targetSelesaiHariIni:
            targetSelesaiHariIni,
            totalTargetHariIni:
            totalTargetHariIni,
            hafalanCount:
            hafalanCount,
            ibadahCount:
            ibadahCount,
          ),

              AppSpacing.verticalMd,

          WeeklyConsistencyCard(
            weeklyProgress:
            weeklyProgress,
          ),

              AppSpacing.verticalMd,

          StrengthCard(
            strength: strength,
            improvement:
            improvement,
          ),

              AppSpacing.verticalMd,

          SmartResumeCard(
            summary: smartResume,
          ),

              AppSpacing.verticalMd,

          NavigationCard(
            title: "Ibadah Hari Ini",
            description:
            "Yuk isi checklist ibadah hari ini",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const IbadahScreen(),
                ),
              );
            },
          ),

          NavigationCard(
            title: "Target Harian",
            description:
            "Kelola target belajar untuk Autopilot Learning Engine.",
            buttonText: "Buka",
            onPressed: () async {
              final result =
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const TargetScreen(),
                ),
              );

              if (result == true) {
                await refreshDashboard();

                if (!mounted) return;
              }
            },
          ),

          NavigationCard(
            title: "Riwayat Belajar",
            description:
            "Lihat aktivitas belajar sebelumnya.",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const HistoryScreen(),
                ),
              );
            },
          ),

          NavigationCard(
            title: "Achievement",
            description: "Lihat semua pencapaian belajar.",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AchievementScreen(),
                ),
              );
            },
          ),

          NavigationCard(
            title: "Reward",
            description:
            "Lihat total poin dan riwayat reward.",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RewardScreen(),
                ),
              );
            },
          ),

          NavigationCard(
            title: "Statistik",
            description: "Lihat perkembangan belajar anak.",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StatisticsScreen(),
                ),
              );
            },
          ),

          ProfileGuardianCard(
            guardian: guardian,
            onPressed: () async {
              final result =
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const GuardianScreen(),
                ),
              );

              if (result == true) {
                await refreshDashboard();

                if (!mounted) return;
              }
            },
          ),
        ],),
      ),
    );
  }
}