import 'package:flutter/material.dart';

import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';
import 'common/app_button.dart';
import 'common/app_card.dart';

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
    return AppCard(
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

          AppButton(
            label: buttonText,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}