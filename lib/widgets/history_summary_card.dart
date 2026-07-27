import 'package:flutter/material.dart';

class HistorySummaryCard extends StatelessWidget {
  final int totalDays;

  final int completed;

  final int uncompleted;

  final double completionRate;

  const HistorySummaryCard({
    super.key,
    required this.totalDays,
    required this.completed,
    required this.uncompleted,
    required this.completionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Belajar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _item(
                    "Hari",
                    totalDays.toString(),
                  ),
                ),
                Expanded(
                  child: _item(
                    "Selesai",
                    completed.toString(),
                  ),
                ),
                Expanded(
                  child: _item(
                    "Belum",
                    uncompleted.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: completionRate,
              minHeight: 10,
              borderRadius:
              BorderRadius.circular(12),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${(completionRate * 100).toStringAsFixed(0)}%",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
      String title,
      String value,
      ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}