import '../../models/achievement_rule.dart';

const List<AchievementRule> achievementRules = [
  AchievementRule(
    title: "Langkah Pertama",
    description: "Menyelesaikan target pertama.",
    icon: "emoji_events",
    requiredValue: 1,
  ),

  AchievementRule(
    title: "Semangat Belajar",
    description: "Menyelesaikan 10 target.",
    icon: "military_tech",
    requiredValue: 10,
  ),

  AchievementRule(
    title: "Pejuang Ilmu",
    description: "Menyelesaikan 50 target.",
    icon: "workspace_premium",
    requiredValue: 50,
  ),
];