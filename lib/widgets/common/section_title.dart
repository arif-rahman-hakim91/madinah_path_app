import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_style.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalMd,
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.title,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ],
    );
  }
}