import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Hari Ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Ringkasan aktivitas belajar hari ini.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                _item(
                  Icons.flag,
                  Colors.green,
                  "$targetSelesaiHariIni/$totalTargetHariIni",
                  "Target",
                ),

                const SizedBox(width: 12),

                _item(
                  Icons.menu_book,
                  Colors.blue,
                  "$hafalanCount",
                  "Hafalan",
                ),

                const SizedBox(width: 12),

                _item(
                  Icons.mosque,
                  Colors.orange,
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

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}