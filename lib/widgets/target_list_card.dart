import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_style.dart';
import '../models/target.dart';
import '../widgets/common/app_card.dart';
import '../widgets/common/app_empty.dart';
import '../widgets/common/app_section_title.dart';

class TargetListCard extends StatelessWidget {
  final List<Target> learningFlow;
  final Function(Target) onTap;
  final VoidCallback onAddTarget;

  const TargetListCard({
    super.key,
    required this.learningFlow,
    required this.onTap,
    required this.onAddTarget,
  });

  @override
  Widget build(BuildContext context) {
    if (learningFlow.isEmpty) {
      return AppCard(
        child: AppEmpty(
          icon: Icons.menu_book_outlined,
          title: "Belum ada target hari ini",
          message: "Silakan tambahkan target belajar terlebih dahulu.",
          action: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onAddTarget,
              icon: const Icon(Icons.add),
              label: const Text("Tambah Target"),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacing.verticalLg,

        Row(
          children: [
            const Expanded(
              child: AppSectionTitle(
                title: "Target Hari Ini",
                icon: Icons.workspace_premium,
              ),
            ),

            TextButton.icon(
              onPressed: onAddTarget,
              icon: const Icon(
                Icons.add,
                size: 18,
              ),
              label: const Text("Tambah"),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 0,
                ),
              ),
            ),
          ],
        ),

        AppSpacing.verticalMd,

        ...learningFlow.take(5).map((target) {
          Color statusColor;
          String statusLabel = target.status;

          switch (target.status) {
            case "Belum Lancar":
              statusLabel = "Perdana";
              statusColor = Colors.orange;
              break;

            case "Belum Dipelajari":
              statusLabel = "Ulang";
              statusColor = Colors.red;
              break;

            case "Cukup":
              statusColor = Colors.amber;
              break;

            case "Lancar":
              statusColor = Colors.green;
              break;

            case "Mutqin":
              statusColor = Colors.blue;
              break;

            default:
              statusColor = AppColors.textSecondary;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(
                vertical: -3,
              ),
              onTap: () => onTap(target),

              leading: CircleAvatar(
                radius: 16,
                backgroundColor: target.isCompleted
                    ? Colors.green.shade100
                    : Colors.grey.shade200,
                child: Icon(
                  target.isCompleted
                      ? Icons.check
                      : Icons.menu_book,
                  size: 16,
                  color: target.isCompleted
                      ? Colors.green
                      : Colors.grey,
                ),
              ),

              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      target.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      target.kategori,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          );
        }),

      ],
    );
  }
}