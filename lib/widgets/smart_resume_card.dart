import 'package:flutter/material.dart';

class SmartResumeCard extends StatelessWidget {
  final String summary;

  const SmartResumeCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Icon(
              Icons.lightbulb,
              color: Colors.amber,
              size: 32,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Smart Resume",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    summary,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}