class Statistics {
  final int totalTarget;

  final int completedTarget;

  final int totalAchievement;

  final int totalPoint;

  final int streak;

  const Statistics({
    required this.totalTarget,
    required this.completedTarget,
    required this.totalAchievement,
    required this.totalPoint,
    required this.streak,
  });

  double get progress {
    if (totalTarget == 0) {
      return 0;
    }

    return completedTarget / totalTarget;
  }

  int get progressPercent {
    return (progress * 100).round();
  }
}