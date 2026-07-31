import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../smart_resume_card.dart';
import '../strength_card.dart';
import '../summary_card.dart';
import '../weekly_consistency_card.dart';

class DashboardSummarySection extends StatelessWidget {
  final int targetSelesaiHariIni;
  final int totalTargetHariIni;

  final int hafalanCount;
  final int ibadahCount;

  final List<double> weeklyProgress;

  final String strength;
  final String improvement;

  final String smartResume;

  const DashboardSummarySection({
    super.key,
    required this.targetSelesaiHariIni,
    required this.totalTargetHariIni,
    required this.hafalanCount,
    required this.ibadahCount,
    required this.weeklyProgress,
    required this.strength,
    required this.improvement,
    required this.smartResume,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryCard(
          targetSelesaiHariIni: targetSelesaiHariIni,
          totalTargetHariIni: totalTargetHariIni,
          hafalanCount: hafalanCount,
          ibadahCount: ibadahCount,
        ),

        AppSpacing.verticalMd,

        WeeklyConsistencyCard(
          weeklyProgress: weeklyProgress,
        ),

        AppSpacing.verticalMd,

        StrengthCard(
          strength: strength,
          improvement: improvement,
        ),

        AppSpacing.verticalMd,

        SmartResumeCard(
          summary: smartResume,
        ),
      ],
    );
  }
}