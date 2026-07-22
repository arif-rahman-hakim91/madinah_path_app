import 'package:flutter/material.dart';

class TargetTodayCard extends StatelessWidget {
  final int totalTargetHariIni;
  final int targetSelesaiHariIni;

  const TargetTodayCard({
    super.key,
    required this.totalTargetHariIni,
    required this.targetSelesaiHariIni,
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

              Text(
                "$targetSelesaiHariIni/$totalTargetHariIni",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
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
            ),
          ),

          const SizedBox(height: 12),

          Text(
            totalTargetHariIni == 0
                ? "Belum ada target hari ini."
                : "$totalTargetHariIni target belajar hari ini.",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}