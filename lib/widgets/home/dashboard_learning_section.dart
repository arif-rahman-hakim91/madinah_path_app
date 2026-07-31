import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../models/target.dart';
import '../common/app_card.dart';
import '../target_list_card.dart';
import '../target_today_card.dart';

class DashboardLearningSection extends StatelessWidget {
  final int totalTargetHariIni;
  final int targetSelesaiHariIni;
  final String learningMessage;
  final List<Target> learningFlow;

  final ValueChanged<Target> onTap;
  final Future<void> Function() onAddTarget;

  const DashboardLearningSection({
    super.key,
    required this.totalTargetHariIni,
    required this.targetSelesaiHariIni,
    required this.learningMessage,
    required this.learningFlow,
    required this.onTap,
    required this.onAddTarget,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TargetTodayCard(
            totalTargetHariIni: totalTargetHariIni,
            targetSelesaiHariIni: targetSelesaiHariIni,
            learningMessage: learningMessage,
          ),
          TargetListCard(
            learningFlow: learningFlow,
            onTap: onTap,
            onAddTarget: onAddTarget,
          ),
          AppSpacing.verticalMd,
        ],
      ),
    );
  }
}