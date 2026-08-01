import 'package:flutter/material.dart';

import '../core/extensions/icon_extension.dart';
import '../models/achievement.dart';
import '../services/achievement_service.dart';
import '../widgets/common/empty_state.dart';

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
      body: RefreshIndicator(
        onRefresh: loadAchievements,
        child: achievements.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 120),
            EmptyState(
              icon: Icons.emoji_events_outlined,
              title: "Belum Ada Achievement",
              description:
              "Selesaikan target belajar untuk membuka achievement pertama.",
            ),
          ],
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final achievement =
            achievements[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      achievement.icon.toIcon(),
                      color: Colors.amber,
                      size: 36,
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            achievement.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            achievement.description,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Dibuka: "
                                "${achievement.unlockedAt.day}/"
                                "${achievement.unlockedAt.month}/"
                                "${achievement.unlockedAt.year}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}