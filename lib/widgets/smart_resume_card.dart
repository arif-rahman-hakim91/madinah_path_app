import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class SmartResumeCard extends StatelessWidget {
  final String summary;

  const SmartResumeCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdRadius,
      ),
      child: Padding(
        padding: AppSpacing.card,
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Icon(
              Icons.lightbulb,
              color: AppColors.warning,
              size: 32,
            ),

            AppSpacing.horizontalMd,

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Smart Resume",
                    style: AppTextStyle.title,
                  ),

                  AppSpacing.verticalMd,

                  Text(
                    summary,
                    style: AppTextStyle.body.copyWith(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}