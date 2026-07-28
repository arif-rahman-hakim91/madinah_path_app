import 'package:flutter/material.dart';

import '../core/theme/app_category_colors.dart';
import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class StrengthCard extends StatelessWidget {
  final String strength;
  final String improvement;

  const StrengthCard({
    super.key,
    required this.strength,
    required this.improvement,
  });

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
              "Kelebihan & Perlu Ditingkatkan",
              style: AppTextStyle.title,
            ),

            AppSpacing.verticalLg,

            const Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: AppCategoryColors.target,
                ),
                SizedBox(width: 10),
                Text(
                  "Kelebihan",
                  style: AppTextStyle.subtitle,
                ),
              ],
            ),

            AppSpacing.verticalMd,

            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    strength,
                    style: AppTextStyle.body,
                  ),
                ),
              ],
            ),

            AppSpacing.verticalLg,

            const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppCategoryColors.ibadah,
                ),
                SizedBox(width: 10),
                Text(
                  "Perlu Ditingkatkan",
                  style: AppTextStyle.subtitle,
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 8,
                ),

                AppSpacing.horizontalSm,

                Expanded(
                  child: Text(
                    improvement,
                    style: AppTextStyle.body,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}