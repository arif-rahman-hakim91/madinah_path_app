import 'package:flutter/material.dart';

class WeeklyConsistencyCard extends StatelessWidget {
  final List<double> weeklyProgress;

  const WeeklyConsistencyCard({
    super.key,
    required this.weeklyProgress,
  });

  Widget _item(
      String day,
      double value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(day),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
            ),
          ),

          const SizedBox(width: 10),

          Text("${(value * 100).toInt()}%"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Konsistensi Mingguan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _item(
              "Senin",
              weeklyProgress.isNotEmpty
                  ? weeklyProgress[0]
                  : 0,
            ),

            _item(
              "Selasa",
              weeklyProgress.length > 1
                  ? weeklyProgress[1]
                  : 0,
            ),

            _item(
              "Rabu",
              weeklyProgress.length > 2
                  ? weeklyProgress[2]
                  : 0,
            ),

            _item(
              "Kamis",
              weeklyProgress.length > 3
                  ? weeklyProgress[3]
                  : 0,
            ),

            _item(
              "Jum'at",
              weeklyProgress.length > 4
                  ? weeklyProgress[4]
                  : 0,
            ),

            _item(
              "Sabtu",
              weeklyProgress.length > 5
                  ? weeklyProgress[5]
                  : 0,
            ),

            _item(
              "Ahad",
              weeklyProgress.length > 6
                  ? weeklyProgress[6]
                  : 0,
            ),
          ],
        ),
      ),
    );
  }
}