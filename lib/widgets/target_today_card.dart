import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class TargetTodayCard extends StatelessWidget {
  final int totalTargetHariIni;
  final int targetSelesaiHariIni;
  final String? learningMessage;

  const TargetTodayCard({
    super.key,
    required this.totalTargetHariIni,
    required this.targetSelesaiHariIni,
    this.learningMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.card,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.mdRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.today,
                color: AppColors.primary,
                size: 28,
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "Target Hari Ini",
                  style: AppTextStyle.title,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$targetSelesaiHariIni/$totalTargetHariIni",
                    style: AppTextStyle.subtitle,
                  ),

                  Text(
                    totalTargetHariIni == 0
                        ? "0%"
                        : "${((targetSelesaiHariIni / totalTargetHariIni) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: totalTargetHariIni == 0
                  ? 0
                  : targetSelesaiHariIni / totalTargetHariIni,
              minHeight: 10,
              borderRadius: BorderRadius.circular(30),
              valueColor: AlwaysStoppedAnimation<Color>(
                totalTargetHariIni == 0
                    ? AppColors.progressEmpty
                    : (targetSelesaiHariIni / totalTargetHariIni) >= 0.8
                    ? AppColors.progressHigh
                    : (targetSelesaiHariIni / totalTargetHariIni) >= 0.5
                    ? AppColors.progressMedium
                    : AppColors.progressLow
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            totalTargetHariIni == 0
                ? "Belum ada target hari ini."
                : "🎯 $totalTargetHariIni target belajar hari ini.",
            style: AppTextStyle.caption,
          ),

          if (learningMessage != null &&
              learningMessage!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),

            Text(
              learningMessage!,
              style: AppTextStyle.body.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}