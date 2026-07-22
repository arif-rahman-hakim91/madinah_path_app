import 'package:flutter/material.dart';

class StrengthCard extends StatelessWidget {
  final String strength;
  final String improvement;

  const StrengthCard({
    super.key,
    required this.strength,
    required this.improvement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Kelebihan & Perlu Ditingkatkan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                ),
                SizedBox(width: 10),
                Text(
                  "Kelebihan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(strength),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
                SizedBox(width: 10),
                Text(
                  "Perlu Ditingkatkan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 8,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(improvement),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}