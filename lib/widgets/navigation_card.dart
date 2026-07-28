import 'package:flutter/material.dart';

import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';

class NavigationCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const NavigationCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
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
            Text(
              title,
                style: AppTextStyle.title,
            ),

            AppSpacing.verticalSm,

            Text(
              description,
              style: AppTextStyle.body,
            ),

            AppSpacing.verticalMd,

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: AppTextStyle.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}