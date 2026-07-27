import 'package:flutter/material.dart';

import '../models/child.dart';
import '../services/current_child_service.dart';
import '../services/history_service.dart';
import 'history_detail_screen.dart';
import 'history_calendar_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  final HistoryService historyService =
  HistoryService();

  List<DateTime> dates = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadHistory();
  }

  Future<void> loadHistory() async {
    setState(() {
      isLoading = true;
    });

    final Child? child =
        CurrentChildService.currentChild;

    if (child == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final result =
    await historyService.getLearningDates(
      child.id!,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      dates = result;
      isLoading = false;
    });
  }

  String formatDate(
      DateTime date,
      ) {
    const months = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return "${date.day} ${months[date.month]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Belajar",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const HistoryCalendarScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.calendar_month,
            ),
          ),
        ],
      ),
        body: RefreshIndicator(
          onRefresh: loadHistory,
          child: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : dates.isEmpty
          ? Center(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.history,
                  size: 70,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  "Belum ada riwayat belajar.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Selesaikan target hari ini untuk mulai membangun riwayat belajar.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
          : ListView.builder(
        padding:
        const EdgeInsets.all(16),
        itemCount: dates.length,
        itemBuilder:
            (context, index) {
          final date =
          dates[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
              ),
              title: Text(
                formatDate(date),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryDetailScreen(
                      date: date,
                    ),
                  ),
                );

                if (!mounted) {
                  return;
                }

                await loadHistory();
              },
            ),
          );
        },
      ),
        )
    );
  }
}