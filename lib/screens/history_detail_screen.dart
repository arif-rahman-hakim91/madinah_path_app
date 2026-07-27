import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/history_item.dart';
import '../services/current_child_service.dart';
import '../services/history_service.dart';

class HistoryDetailScreen extends StatefulWidget {
  final DateTime date;

  const HistoryDetailScreen({
    super.key,
    required this.date,
  });

  @override
  State<HistoryDetailScreen> createState() =>
      _HistoryDetailScreenState();
}

class _HistoryDetailScreenState
    extends State<HistoryDetailScreen> {
  final HistoryService historyService =
  HistoryService();

  List<HistoryItem> history = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final Child? child =
        CurrentChildService.currentChild;

    if (child == null) {
      setState(() {
        isLoading = false;
      });

      return;
    }

    final result =
    await historyService.getHistoryByDate(
      child.id!,
      widget.date,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      history = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Riwayat",
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : history.isEmpty
          ? const Center(
        child: Text(
          "Belum ada data.",
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder:
            (context, index) {
          final item =
          history[index];

          return Card(
            child: ListTile(
              leading: Icon(
                item.dailyTarget
                    .isCompleted
                    ? Icons
                    .check_circle
                    : Icons
                    .radio_button_unchecked,
                color: item
                    .dailyTarget
                    .isCompleted
                    ? Colors.green
                    : Colors.grey,
              ),
              title: Text(
                item.target.nama,
              ),
              subtitle: Text(
                item.target.kategori,
              ),
              trailing: Text(
                item.target.status,
              ),
            ),
          );
        },
      ),
    );
  }
}