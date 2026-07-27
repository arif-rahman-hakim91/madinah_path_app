import 'package:flutter/material.dart';

import '../models/achievement.dart';
import '../services/achievement_service.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() =>
      _AchievementScreenState();
}

class _AchievementScreenState
    extends State<AchievementScreen> {

  final service = AchievementService();

  List<Achievement> achievements = [];

  @override
  void initState() {
    super.initState();

    loadAchievements();
  }

  Future<void> loadAchievements() async {
    final result = await service.getAll();

    if (!mounted) return;

    setState(() {
      achievements = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Achievement",
        ),
        centerTitle: true,
      ),
      body: achievements.isEmpty
          ? const Center(
        child: Text(
          "Belum ada achievement.",
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets.all(16),
        itemCount:
        achievements.length,
        itemBuilder:
            (context, index) {
          final achievement =
          achievements[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.emoji_events,
                color: Colors.amber,
              ),
              title: Text(
                achievement.title,
              ),
              subtitle: Text(
                achievement.description,
              ),
            ),
          );
        },
      ),
    );
  }
}