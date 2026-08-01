import 'package:flutter/material.dart';

// Models
import '../models/guardian.dart';
import '../models/target.dart';
import '../models/dashboard_data.dart';

// Repositories
import '../repositories/daily_target_repository.dart';
import '../repositories/target_repository.dart';

// Services
import '../services/current_child_service.dart';
import '../services/learning_engine.dart';
import '../services/achievement_engine.dart';
import '../services/point_engine.dart';

// Widgets
import '../widgets/navigation_card.dart';
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

//home
import '../widgets/home/dashboard_header_section.dart';
import '../widgets/home/dashboard_learning_section.dart';
import '../widgets/home/dashboard_summary_section.dart';
import '../widgets/home/dashboard_navigation_section.dart';
import '../widgets/home/profile_section.dart';
import '../widgets/home/achievement_section.dart';

//controllers
import '../controllers/dashboard_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dashboardController = DashboardController();
  final targetRepository = TargetRepository();
  final dailyTargetRepository = DailyTargetRepository();

  final AchievementEngine achievementEngine =
  AchievementEngine();

  final PointEngine pointEngine =
  PointEngine();

  final LearningEngine learningEngine =
  LearningEngine();

  List<Target> learningFlow = [];

  String learningMessage = "";

  LearningRecommendation? recommendation;

  String smartResume = "";

  Guardian? guardian;

  double progress = 0;

  int totalTargetHariIni = 0;

  int targetSelesaiHariIni = 0;

  List<Target> todayTargets = [];

  bool isLoading = true;
  DashboardData dashboardData = const DashboardData(
    progress: 0,
    hafalanCount: 0,
    ibadahCount: 0,
    strength: "",
    improvement: "",
    weeklyProgress: [],
  );



  @override
  void initState() {
    super.initState();
    refreshDashboard();
  }


  Future<void> loadTargetSummary() async {
    final summary =
    await dashboardController.loadTargetSummary();

    if (!mounted) return;

    setState(() {
      totalTargetHariIni = summary["total"]!;
      targetSelesaiHariIni = summary["selesai"]!;
    });
  }

  Future<void> loadTodayTargets() async {
    final result =
    await dashboardController.loadTodayTargets();

    if (!mounted) return;

    setState(() {
      todayTargets = result.todayTargets;

      learningFlow = result.learningFlow;

      learningMessage = result.learningMessage;

      smartResume = result.smartResume;
    });
  }
  Future<void> refreshDashboard() async {

    setState(() {
      isLoading = true;
    });

    await Future.wait([
      loadGuardian(),
      loadProgress(),
      loadTargetSummary(),
      loadTodayTargets(),
    ]);

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
    await dashboardController.loadDashboard();

    if (!mounted) return;

    setState(() {
      dashboardData = dashboard;
    });
  }

  Future<void> loadGuardian() async {
    final data =
    await dashboardController.loadGuardian();

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

              DashboardHeaderSection(
                guardian: guardian,
                onChangeChild: pilihAnak,
              ),

              AppSpacing.verticalMd,

              DashboardLearningSection(
                totalTargetHariIni: totalTargetHariIni,
                targetSelesaiHariIni: targetSelesaiHariIni,
                learningMessage: learningMessage,
                learningFlow: learningFlow,
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
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TargetScreen(),
                    ),
                  );

                  if (result == true) {
                    await refreshDashboard();
                  }
                },
              ),

              AppSpacing.verticalMd,

              DashboardSummarySection(
                targetSelesaiHariIni: targetSelesaiHariIni,
                totalTargetHariIni: totalTargetHariIni,
                hafalanCount: dashboardData.hafalanCount,
                ibadahCount: dashboardData.ibadahCount,
                weeklyProgress: dashboardData.weeklyProgress,
                strength: dashboardData.strength,
                improvement: dashboardData.improvement,
                smartResume: smartResume,
              ),

              AppSpacing.verticalMd,

              const AchievementSection(),

              DashboardNavigationSection(
                children: [
                  NavigationCard(
                    title: "Ibadah Hari Ini",
                    description: "Yuk isi checklist ibadah hari ini",
                    buttonText: "Buka",
                    onPressed: () {
                      openScreen(const IbadahScreen());
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
                      openScreen(const HistoryScreen());
                    },
                  ),

                  NavigationCard(
                    title: "Achievement",
                    description: "Lihat semua pencapaian belajar.",
                    buttonText: "Buka",
                    onPressed: () {
                      openScreen(const AchievementScreen());
                    },
                  ),

                  NavigationCard(
                    title: "Reward",
                    description:
                    "Lihat total poin dan riwayat reward.",
                    buttonText: "Buka",
                    onPressed: () {
                      openScreen(const RewardScreen());
                    },
                  ),

                  NavigationCard(
                    title: "Statistik",
                    description: "Lihat perkembangan belajar anak.",
                    buttonText: "Buka",
                    onPressed: () {
                      openScreen(const StatisticsScreen());
                    },
                  ),
                ],
              ),

              ProfileSection(
                guardian: guardian,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GuardianScreen(),
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