import 'package:flutter/material.dart';

import '../models/target.dart';

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
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        const Row(
          children: [

            Icon(
              Icons.workspace_premium,
              color: Colors.green,
              size: 22,
            ),

            SizedBox(width: 8),

            Text(
              "Target Belajar Hari Ini",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        ...learningFlow.take(5).toList().map((target) {
          Color statusColor;

          switch (target.status) {
            case "Belum Lancar":
              statusColor = Colors.orange;
              break;

            case "Belum Dipelajari":
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
              statusColor = Colors.grey;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: ListTile(
              onTap: () => onTap(target),

              leading: CircleAvatar(
                backgroundColor: target.isCompleted
                    ? Colors.green.shade100
                    : Colors.grey.shade200,
                child: Icon(
                  target.isCompleted
                      ? Icons.check
                      : Icons.menu_book,
                  color: target.isCompleted
                      ? Colors.green
                      : Colors.grey,
                ),
              ),

              title: Text(
                target.nama,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    target.kategori,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(
                        alpha: 0.12,
                      ),
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      target.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAddTarget,
            icon: const Icon(Icons.add),
            label: const Text(
              "Tambah Target",
            ),
          ),
        ),
      ],
    );
  }
}