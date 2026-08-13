import 'package:flutter/material.dart';

import '../models/statistics.dart';
import '../models/statistics_weekly.dart';
import '../services/statistics_service.dart';
import '../services/statistics_engine.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() =>
      _StatisticsScreenState();
}

class _StatisticsScreenState
    extends State<StatisticsScreen> {
  final StatisticsService service =
  StatisticsService();

  final StatisticsEngine engine =
  const StatisticsEngine();

  Statistics? statistics;

  List<StatisticsWeekly> weeklyStatistics = [];

  bool isLoading = true;

  String? errorMessage;

  @override
  void initState() {
    super.initState();

    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      final result =
      await service.getStatistics();

      final weeklyResult =
      await service.getWeeklyStatistics();

      if (!mounted) return;

      setState(() {
        statistics = result;
        weeklyStatistics = weeklyResult;

        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage =
        "Tidak dapat memuat statistik.";
      });
    }
  }

  Widget _buildTodayProgress() {
    final total = statistics!.totalTarget;

    final selesai =
        statistics!.completedTarget;

    final progress =
        statistics!.progress;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Perkembangan Hari Ini",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                "${statistics!.progressPercent}%",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              borderRadius:
              BorderRadius.circular(10),
            ),

            const SizedBox(height: 12),

            Center(
              child: Text(
                "$selesai dari $total target selesai",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart() {
    if (weeklyStatistics.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Belum ada data belajar minggu ini.",
          ),
        ),
      );
    }

    final maxTarget =
    weeklyStatistics.fold<int>(
      0,
          (max, item) {
        return item.total > max
            ? item.total
            : max;
      },
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Belajar Minggu Ini",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Semakin panjang batang, "
                  "semakin banyak target yang selesai.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            ...weeklyStatistics.map(
                  (item) {
                final ratio =
                maxTarget == 0
                    ? 0.0
                    : item.selesai /
                    maxTarget;

                return Padding(
                  padding:
                  const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 55,
                        child: Text(
                          item.hari,
                          style:
                          const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 24,
                              decoration:
                              BoxDecoration(
                                color: Colors
                                    .grey
                                    .shade200,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  6,
                                ),
                              ),
                            ),

                            FractionallySizedBox(
                              widthFactor: ratio,
                              child: Container(
                                height: 24,
                                decoration:
                                BoxDecoration(
                                  color:
                                  Colors.green,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      SizedBox(
                        width: 40,
                        child: Text(
                          "${item.selesai}/${item.total}",
                          textAlign:
                          TextAlign.right,
                          style:
                          const TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningInsight() {
    if (weeklyStatistics.isEmpty) {
      return const SizedBox.shrink();
    }

    final belumSelesai =
        weeklyStatistics.where(
              (item) {
            return item.total > 0 &&
                item.selesai < item.total;
          },
        ).length;

    if (belumSelesai == 0) {
      return const Card(
        child: ListTile(
          leading: Icon(
            Icons.check_circle,
          ),
          title: Text(
            "Alhamdulillah, target minggu ini selesai.",
          ),
          subtitle: Text(
            "Pertahankan kebiasaan belajar yang baik.",
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.lightbulb_outline,
        ),
        title: const Text(
          "Perlu sedikit perhatian",
        ),
        subtitle: Text(
          "$belumSelesai hari masih memiliki "
              "target yang belum selesai.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Statistik",
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding:
            const EdgeInsets.all(20),
            child: Text(
              errorMessage!,
              textAlign:
              TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (statistics == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Anak yang aktif belum dipilih.",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statistik",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding:
        const EdgeInsets.all(16),
        children: [
          _buildTodayProgress(),

          const SizedBox(height: 20),

          _buildWeeklyChart(),

          const SizedBox(height: 20),

          _buildLearningInsight(),
        ],
      ),
    );
  }
}