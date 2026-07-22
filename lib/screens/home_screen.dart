import 'package:flutter/material.dart';

// Models
import '../models/guardian.dart';
import '../models/target.dart';

// Repositories
import '../repositories/guardian_repository.dart';
import '../repositories/target_repository.dart';

// Services
import '../services/current_child_service.dart';
import '../services/dashboard_service.dart';
import '../services/learning_engine.dart';

// Widgets
import '../widgets/active_child_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/navigation_card.dart';
import '../widgets/profile_guardian_card.dart';
import '../widgets/quick_menu_card.dart';
import '../widgets/strength_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/target_list_card.dart';
import '../widgets/target_today_card.dart';
import '../widgets/weekly_consistency_card.dart';

// Screens
import 'child_selector_screen.dart';
import 'guardian_screen.dart';
import 'hafalan_screen.dart';
import 'ibadah_screen.dart';
import 'profile_screen.dart';
import 'target_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dashboardService = DashboardService();
  final guardianRepository = GuardianRepository();
  final targetRepository = TargetRepository();
  final LearningEngine learningEngine = LearningEngine();

  List<Target> learningFlow = [];
  String learningMessage = "";
  LearningRecommendation? recommendation;

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

  @override
  void initState() {
    super.initState();

    loadGuardian();
    loadProgress();
    loadTargetSummary();
    loadTodayTargets();
  }

  Future<void> loadTargetSummary() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final summary = await targetRepository.getTodaySummary(
      child.id!,
    );

    if (!mounted) return;

    setState(() {
      totalTargetHariIni = summary["total"] ?? 0;
      targetSelesaiHariIni = summary["selesai"] ?? 0;
    });
  }

  Future<void> loadTodayTargets() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final result = await learningEngine.getTodayTargets(
      child,
    );

    if (!mounted) return;

    setState(() {
      todayTargets = result;

      learningFlow =
          learningEngine.generateLearningFlow(result);

      learningMessage =
          learningEngine.getGreetingMessage(result);

      recommendation =
          learningEngine.generateRecommendation(result);
    });
  }

  Future<void> loadProgress() async {
    final dashboard = await dashboardService.loadDashboard();

    if (!mounted) return;

    setState(() {
      progress = dashboard.progress;
      ibadahCount = dashboard.ibadahCount;
      hafalanCount = dashboard.hafalanCount;

      strength = dashboard.strength;
      improvement = dashboard.improvement;

      weeklyProgress = dashboard.weeklyProgress;
    });
  }

  Future<void> loadGuardian() async {
    final data = await guardianRepository.getGuardian();

    if (!mounted) return;

    setState(() {
      guardian = data;
    });
  }

  Future<void> pilihAnak() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChildSelectorScreen(),
      ),
    );

    if (result == true) {
      await loadProgress();
      await loadGuardian();
      await loadTargetSummary();
      await loadTodayTargets();

      if (!mounted) return;

      setState(() {});
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Madinah Path"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
//GREETING HEADER.DART
          const SizedBox(height: 20),

          GreetingHeader(
            guardian: guardian,
          ),


          const SizedBox(height: 30,),
//ACTIVE CHILD CARD.DART
          ActiveChildCard(
            onChangeChild: pilihAnak,
          ),
          const SizedBox(height: 20,),

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


//TARGET TODAY CARD.DART
                TargetTodayCard(
                  totalTargetHariIni: totalTargetHariIni,
                  targetSelesaiHariIni: targetSelesaiHariIni,
                  learningMessage: learningMessage,
                ),
//TARGET LIST CARD.DART
                TargetListCard(
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
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                target.nama,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                target.kategori,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 24),

                              const Text(
                                "Bagaimana hasil belajar hari ini?",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              _evaluationButton(
                                icon: Icons.refresh,
                                title: "Belum Lancar",
                                color: Colors.orange,
                                onTap: () async {
                                  await updateTargetStatus(
                                    target,
                                    "Belum Lancar",
                                  );
                                },
                              ),

                              _evaluationButton(
                                icon: Icons.trending_up,
                                title: "Cukup",
                                color: Colors.blue,
                                onTap: () async {
                                  await updateTargetStatus(
                                    target,
                                    "Cukup",
                                  );
                                },
                              ),

                              _evaluationButton(
                                icon: Icons.check_circle,
                                title: "Lancar",
                                color: Colors.green,
                                onTap: () async {
                                  await updateTargetStatus(
                                    target,
                                    "Lancar",
                                  );
                                },
                              ),

                              _evaluationButton(
                                icon: Icons.workspace_premium,
                                title: "Mutqin",
                                color: Colors.purple,
                                onTap: () async {
                                  await updateTargetStatus(
                                    target,
                                    "Mutqin",
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 20,),



                              ],
            ),
            ),
          ),

          const SizedBox(height: 20,),
//SUMMARY CARD.DART
          SummaryCard(
            targetSelesaiHariIni: targetSelesaiHariIni,
            totalTargetHariIni: totalTargetHariIni,
            hafalanCount: hafalanCount,
            ibadahCount: ibadahCount,
          ),

          const SizedBox(height: 20,),
//WEEKLY CONSISTENCY CARD DART
          WeeklyConsistencyCard(
            weeklyProgress: weeklyProgress,
          ),

          const SizedBox(height: 20,),
//STRENGHT CARD.DART
          StrengthCard(
            strength: strength,
            improvement: improvement,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HafalanScreen(),
              ),
              );
            },
              icon: const Icon(Icons.menu_book),
              label: const Text("Buka Halaman Hafalan"),),
          ),
//NAVIGATION CARD.DART
          NavigationCard(
            title: "Ibadah Hari Ini",
            description: "Yuk isi checklist ibadah hari ini",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const IbadahScreen(),
                ),
              );
            },
          ),

          NavigationCard(
            title: "Target Harian",
            description: "Kelola target belajar untuk Autopilot Learning Engine.",
            buttonText: "Buka",
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TargetScreen(),
                ),
              );

              if (result == true) {
                await loadTargetSummary();
                await loadTodayTargets();

                if (!mounted) return;

                setState(() {});
              }
            },
          ),

          NavigationCard(
            title: "Profil Anak",
            description: "Lihat informasi anak dan pengaturan aplikasi.",
            buttonText: "Buka",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
//PROFIL GUARDIAN CARD.DART
          ProfileGuardianCard(
            guardian: guardian,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GuardianScreen(),
                ),
              );

              if (result == true) {
                await loadGuardian();
                await loadProgress();

                if (!mounted) return;

                setState(() {});
              }
            },
          ),
//QUICK MENU CARD.DART
          QuickMenuCard(
            onHafalan: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HafalanScreen(),
                ),
              );
            },
            onIbadah: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const IbadahScreen(),
                ),
              );
            },
            onProfile: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  Future<void> updateTargetStatus(
      Target target,
      String status,
      ) async {
    final updated = target.copyWith(
      status: status,
      isCompleted: status == "Mutqin",
      updatedAt: DateTime.now(),
    );

    await targetRepository.update(updated);

    if (!mounted) return;

    Navigator.pop(context);

    await Future.wait([
      loadTargetSummary(),
      loadTodayTargets(),
      loadProgress(),
    ]);

    setState(() {});
  }

  Widget _evaluationButton({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    ),
  );
}

}
