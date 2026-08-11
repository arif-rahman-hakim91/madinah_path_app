import 'package:flutter/material.dart';

import '../../models/achievement.dart';
import '../../screens/achievement_screen.dart';
import '../../services/achievement_service.dart';
import '../common/app_card.dart';

class AchievementSection extends StatefulWidget {
  const AchievementSection({super.key});

  @override
  State<AchievementSection> createState() =>
      _AchievementSectionState();
}

class _AchievementSectionState
    extends State<AchievementSection> {

  final AchievementService service =
  AchievementService();

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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AchievementScreen(),
            ),
          );
        },
        child: Row(
          children: [
            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 22,
            ),

            const SizedBox(width: 10),

            const Text(
              "Achievement",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Text(
                achievements.length.toString(),
                style: TextStyle(
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}