import 'package:flutter/material.dart';

class HistoryChartCard extends StatelessWidget {
  final List<double> progress;

  const HistoryChartCard({
    super.key,
    required this.progress,
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
              "Grafik 7 Hari",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 160,
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: progress.map((value) {
                  return Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          Text(
                            "${(value * 100).toStringAsFixed(0)}%",
                            style:
                            const TextStyle(
                              fontSize: 11,
                            ),
                          ),

                          const SizedBox(height: 4),

                          FractionallySizedBox(
                            heightFactor: value,
                            child: Container(
                              height: 120,
                              decoration:
                              BoxDecoration(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  8,
                                ),
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}