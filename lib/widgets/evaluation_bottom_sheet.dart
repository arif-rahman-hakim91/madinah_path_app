import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';
import '../models/target.dart';

class EvaluationBottomSheet extends StatelessWidget {
  final Target target;

  final void Function(String status) onEvaluate;

  const EvaluationBottomSheet({
    super.key,
    required this.target,
    required this.onEvaluate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.page,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            target.nama,
            style: AppTextStyle.headline,
          ),

          const SizedBox(height: 8),

          Text(
            target.kategori,
            style: AppTextStyle.caption,
          ),

          AppSpacing.verticalLg,

          const Text(
            "Bagaimana hasil belajar hari ini?",
            style: AppTextStyle.subtitle,
          ),

          const SizedBox(height: 20),

          _buildButton(
            context,
            icon: Icons.refresh,
            title: "Belum Lancar",
            color: Colors.orange,
          ),

          _buildButton(
            context,
            icon: Icons.trending_up,
            title: "Cukup",
            color: Colors.blue,
          ),

          _buildButton(
            context,
            icon: Icons.check_circle,
            title: "Lancar",
            color: Colors.green,
          ),

          _buildButton(
            context,
            icon: Icons.workspace_premium,
            title: "Mutqin",
            color: Colors.purple,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Color color,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => onEvaluate(title),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyle.body,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}