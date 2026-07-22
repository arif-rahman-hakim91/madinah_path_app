import 'package:flutter/material.dart';

import '../models/target.dart';

class TargetListCard extends StatelessWidget {
  final List<Target> learningFlow;
  final Function(Target) onTap;

  const TargetListCard({
    super.key,
    required this.learningFlow,
    required this.onTap,
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

        const Text(
          "Target Belajar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ...learningFlow.take(5).map((target) {

          Color statusColor;

          switch (target.status) {
            case "Belum Lancar":
              statusColor = Colors.orange;
              break;

            case "Belum Dipelajari":
              statusColor = Colors.red;
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

              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: target.isCompleted
                      ? Colors.green.shade100
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  target.isCompleted
                      ? Icons.check
                      : Icons.play_arrow,
                  color: target.isCompleted
                      ? Colors.green
                      : Colors.orange,
                ),
              ),

              title: Text(
                target.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                target.kategori,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
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
            ),
          );
        }),
      ],
    );
  }
}