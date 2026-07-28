import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class WeeklyConsistencyCard extends StatelessWidget {
  final List<double> weeklyProgress;

  const WeeklyConsistencyCard({
    super.key,
    required this.weeklyProgress,
  });

  Widget _item(
      String day,
      double value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              day,
              style: AppTextStyle.body,
            ),
          ),

          AppSpacing.horizontalSm,

          Expanded(
            child: LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.divider,
              value: value,
              minHeight: 10,
            ),
          ),

          AppSpacing.horizontalSm,

          Text(
            "${(value * 100).toInt()}%",
            style: AppTextStyle.body,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdRadius,
      ),
      child: Padding(
        padding: AppSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Konsistensi Mingguan",
              style: AppTextStyle.title,
            ),

            AppSpacing.verticalLg,

            _item(
              "Senin",
              weeklyProgress.isNotEmpty
                  ? weeklyProgress[0]
                  : 0,
            ),

            _item(
              "Selasa",
              weeklyProgress.length > 1
                  ? weeklyProgress[1]
                  : 0,
            ),

            _item(
              "Rabu",
              weeklyProgress.length > 2
                  ? weeklyProgress[2]
                  : 0,
            ),

            _item(
              "Kamis",
              weeklyProgress.length > 3
                  ? weeklyProgress[3]
                  : 0,
            ),

            _item(
              "Jum'at",
              weeklyProgress.length > 4
                  ? weeklyProgress[4]
                  : 0,
            ),

            _item(
              "Sabtu",
              weeklyProgress.length > 5
                  ? weeklyProgress[5]
                  : 0,
            ),

            _item(
              "Ahad",
              weeklyProgress.length > 6
                  ? weeklyProgress[6]
                  : 0,
            ),
          ],
        ),
      ),
    );
  }
}