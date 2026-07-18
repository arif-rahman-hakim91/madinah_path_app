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

  late Future<List<Achievement>> achievements;

  @override
  void initState() {
    super.initState();

    achievements = service.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievement"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Achievement>>(
        future: achievements,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada achievement.",
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {

              final item = data[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(

                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.workspace_premium,
                      color: Colors.white,
                    ),
                  ),

                  title: Text(item.title),

                  subtitle: Text(item.description),

                  trailing: Text(
                    "${item.unlockedAt.day.toString().padLeft(2, '0')}/"
                        "${item.unlockedAt.month.toString().padLeft(2, '0')}/"
                        "${item.unlockedAt.year}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}