import 'package:flutter/material.dart';


import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';
import '../core/theme/app_category_colors.dart';

class SummaryCard extends StatelessWidget {
  final int targetSelesaiHariIni;
  final int totalTargetHariIni;
  final int hafalanCount;
  final int ibadahCount;

  const SummaryCard({
    super.key,
    required this.targetSelesaiHariIni,
    required this.totalTargetHariIni,
    required this.hafalanCount,
    required this.ibadahCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdRadius,
      ),
      child: Padding(
        padding: AppSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Hari Ini",
              style: AppTextStyle.title,
            ),

            AppSpacing.verticalLg,

            const Text(
              "Ringkasan aktivitas belajar hari ini.",
              style: AppTextStyle.caption,
            ),

            AppSpacing.verticalLg,

            Row(
              children: [
                _item(
                  Icons.flag,
                  AppCategoryColors.target,
                  "$targetSelesaiHariIni/$totalTargetHariIni",
                  "Target",
                ),

                AppSpacing.horizontalMd,

                _item(
                  Icons.menu_book,
                  AppCategoryColors.hafalan,
                  "$hafalanCount",
                  "Hafalan",
                ),

                AppSpacing.horizontalMd,

                _item(
                  Icons.mosque,
                  AppCategoryColors.ibadah,
                  "$ibadahCount",
                  "Ibadah",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
      IconData icon,
      Color color,
      String value,
      String title,
      ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),

          AppSpacing.verticalSm,

          Text(
            value,
            style: AppTextStyle.headline,
          ),

          AppSpacing.verticalXs,

          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}