import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_radius.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 1,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.mdRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Progress",
                style: AppTextStyle.subtitle,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: LinearProgressIndicator(
                    value: totalTargetHariIni == 0
                        ? 0
                        : targetSelesaiHariIni / totalTargetHariIni,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(30),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      totalTargetHariIni == 0
                          ? AppColors.progressEmpty
                          : (targetSelesaiHariIni / totalTargetHariIni) >= 0.8
                          ? AppColors.progressHigh
                          : (targetSelesaiHariIni / totalTargetHariIni) >= 0.5
                          ? AppColors.progressMedium
                          : AppColors.progressLow,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Text(
                totalTargetHariIni == 0
                    ? "0%"
                    : "${((targetSelesaiHariIni / totalTargetHariIni) * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),


            const SizedBox(height: 10),

            Text(
              learningMessage!,
              style: AppTextStyle.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
      ),
    );
  }
}