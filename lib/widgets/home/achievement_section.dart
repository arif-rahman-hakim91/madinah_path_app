import 'package:flutter/material.dart';

import '../../models/achievement.dart';
import '../../screens/achievement_screen.dart';
import '../../services/achievement_service.dart';
import '../common/app_card.dart';
import '../common/app_section_title.dart';

class AchievementSection extends StatefulWidget {
  const AchievementSection({super.key});

  @override
  State<AchievementSection> createState() =>
      _AchievementSectionState();
}

class _AchievementSectionState
    extends State<AchievementSection> {

  final AchievementService service = AchievementService();

  List<Achievement> achievements = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await service.getAll();

    if (!mounted) return;

    setState(() {
      achievements = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionTitle(
            title: "Achievement",
            icon: Icons.emoji_events,
          ),

          const SizedBox(height: 12),

          Text(
            "${achievements.length} Achievement",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          Text(
            achievements.isEmpty
                ? "Belum ada achievement."
                : achievements.first.title,
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AchievementScreen(),
                  ),
                );
              },
              child: const Text("Lihat Semua"),
            ),
          ),
        ],
      ),
    );
  }
}