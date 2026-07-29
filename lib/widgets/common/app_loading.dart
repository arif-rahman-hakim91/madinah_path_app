import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class AppLoading extends StatelessWidget {
  final String message;

  const AppLoading({
    super.key,
    this.message = "Memuat data...\n\n"
        "Tidaklah seorang hamba bertakwa kepada Allah hingga ia menjaga lisannya.\nAl-Hasan al-Basri",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
          ),

          const SizedBox(height: 16),

          Text(
            message,
            style: AppTextStyle.body,
          ),
        ],
      ),
    );
  }
}