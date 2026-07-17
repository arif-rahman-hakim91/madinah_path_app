import 'package:flutter/material.dart';

import '../models/ibadah.dart';
import '../repositories/ibadah_repository.dart';
import '../services/current_child_service.dart';
import 'ibadah_detail_screen.dart';

class IbadahHistoryScreen extends StatefulWidget {
  const IbadahHistoryScreen({super.key});

  @override
  State<IbadahHistoryScreen> createState() =>
      _IbadahHistoryScreenState();
}

class _IbadahHistoryScreenState
    extends State<IbadahHistoryScreen> {

  final repository = IbadahRepository();

  late Future<List<Ibadah>> history;

  @override
  void initState() {
    super.initState();

    loadHistory();
  }

  void loadHistory() {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      history = Future.value([]);
      return;
    }

    history = repository.getAll(child.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Ibadah"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Ibadah>>(
        future: history,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (CurrentChildService.currentChild == null) {
            return const Center(
              child: Text(
                "Silakan pilih anak terlebih dahulu.",
              ),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada riwayat ibadah.",
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return ListTile(
                leading: const Icon(Icons.calendar_month),

                title: Text(
                  "${item.tanggal.day.toString().padLeft(2, '0')}-"
                      "${item.tanggal.month.toString().padLeft(2, '0')}-"
                      "${item.tanggal.year}",
                ),

                subtitle: Text(
                  "Subuh : ${item.subuh ? "✓" : "✗"}",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IbadahDetailScreen(
                        ibadah: item,
                      ),
                    ),
                  );

                  if (result == true && mounted) {
                    setState(() {
                      loadHistory();
                    });
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}