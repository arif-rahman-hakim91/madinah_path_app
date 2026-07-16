import 'package:flutter/material.dart';

import '../models/ibadah.dart';
import '../repositories/ibadah_repository.dart';
import 'ibadah_screen.dart';

class IbadahDetailScreen extends StatelessWidget {
  final Ibadah ibadah;

  final repository = IbadahRepository();

  IbadahDetailScreen({
    super.key,
    required this.ibadah,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Ibadah"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Shalat Subuh"),
                    trailing: Icon(
                      ibadah.subuh
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Shalat Dzuhur"),
                    trailing: Icon(
                      ibadah.dzuhur
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Shalat Ashar"),
                    trailing: Icon(
                      ibadah.ashar
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Shalat Maghrib"),
                    trailing: Icon(
                      ibadah.maghrib
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Shalat Isya"),
                    trailing: Icon(
                      ibadah.isya
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Tilawah"),
                    trailing: Icon(
                      ibadah.tilawah
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  ListTile(
                    title: const Text("Dzikir Pagi & Petang"),
                    trailing: Icon(
                      ibadah.dzikir
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => IbadahScreen(
                              ibadah: ibadah,
                            ),
                          ),
                        );

                        if (!context.mounted) return;

                        Navigator.pop(context, true);
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: const Text("Hapus"),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Hapus Data"),
                              content: const Text(
                                "Apakah Anda yakin ingin menghapus data ibadah ini?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Batal"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Hapus"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm != true) return;

                        await repository.delete(ibadah.id!);

                        if (!context.mounted) return;

                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}