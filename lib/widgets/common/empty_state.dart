import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_style.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 72,
              color: AppColors.textSecondary,
            ),

            AppSpacing.verticalMd,

            Text(
              title,
              style: AppTextStyle.title,
              textAlign: TextAlign.center,
            ),

            AppSpacing.verticalSm,

            Text(
              description,
              style: AppTextStyle.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}