import 'package:flutter/material.dart';

class TargetTodayCard extends StatelessWidget {
  final int totalTargetHariIni;
  final int targetSelesaiHariIni;
  final String? learningMessage;

  const TargetTodayCard({
    super.key,
    required this.totalTargetHariIni,
    required this.targetSelesaiHariIni,
    this.learningMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.today,
                color: Colors.green,
                size: 28,
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "Target Hari Ini",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$targetSelesaiHariIni/$totalTargetHariIni",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    totalTargetHariIni == 0
                        ? "0%"
                        : "${((targetSelesaiHariIni / totalTargetHariIni) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: totalTargetHariIni == 0
                  ? 0
                  : targetSelesaiHariIni / totalTargetHariIni,
              minHeight: 10,
              borderRadius: BorderRadius.circular(30),
              valueColor: AlwaysStoppedAnimation<Color>(
                totalTargetHariIni == 0
                    ? Colors.grey
                    : (targetSelesaiHariIni / totalTargetHariIni) >= 0.8
                    ? Colors.green
                    : (targetSelesaiHariIni / totalTargetHariIni) >= 0.5
                    ? Colors.orange
                    : Colors.red,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            totalTargetHariIni == 0
                ? "Belum ada target hari ini."
                : "🎯 $totalTargetHariIni target belajar hari ini.",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          if (learningMessage != null &&
              learningMessage!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),

            Text(
              learningMessage!,
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}