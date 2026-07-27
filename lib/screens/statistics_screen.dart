import 'package:flutter/material.dart';

import '../models/statistics.dart';
import '../services/statistics_service.dart';
import '../services/statistics_engine.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() =>
      _StatisticsScreenState();
}

class _StatisticsScreenState
    extends State<StatisticsScreen> {

  final StatisticsService service =
  StatisticsService();

  final StatisticsEngine engine =
  const StatisticsEngine();

  Statistics? statistics;

  @override
  void initState() {
    super.initState();

    loadStatistics();
  }

  Future<void> loadStatistics() async {
    final result =
    await service.getStatistics();

    if (!mounted) return;

    setState(() {
      statistics = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (statistics == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statistik",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Card(
            child: ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Progress"),
              subtitle: Text(
                "${statistics!.progressPercent}%",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text("Level"),
              subtitle: Text(
                engine.learningLevel(
                  statistics!,
                ),
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text("Achievement"),
              trailing: Text(
                "${statistics!.totalAchievement}",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.stars),
              title: const Text("Reward Point"),
              trailing: Text(
                "${statistics!.totalPoint}",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text("Target Selesai"),
              trailing: Text(
                "${statistics!.completedTarget}/${statistics!.totalTarget}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}