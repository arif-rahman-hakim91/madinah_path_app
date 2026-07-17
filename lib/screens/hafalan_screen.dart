import 'package:flutter/material.dart';

import '../models/hafalan.dart';
import '../repositories/hafalan_repository.dart';
import '../services/current_child_service.dart';
import 'add_hafalan_screen.dart';

class HafalanScreen extends StatefulWidget {
  const HafalanScreen({super.key});

  @override
  State<HafalanScreen> createState() => _HafalanScreenState();
}

class _HafalanScreenState extends State<HafalanScreen> {
  final repository = HafalanRepository();

  late Future<List<Hafalan>> _hafalanFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      _hafalanFuture = Future.value([]);
      return;
    }

    _hafalanFuture = repository.getAll(child.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hafalan"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (CurrentChildService.currentChild == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Silakan pilih anak terlebih dahulu.",
                ),
              ),
            );
            return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddHafalanScreen(),
            ),
          );

          if (result == true) {
            setState(() {
              _loadData();
            });
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<Hafalan>>(
              future: _hafalanFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Terjadi kesalahan:\n${snapshot.error}",
                    ),
                  );
                }

                if (CurrentChildService.currentChild == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Silakan pilih anak aktif terlebih dahulu.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final daftarHafalan = snapshot.data ?? [];

                if (daftarHafalan.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Belum ada hafalan.\nTekan tombol + untuk menambahkan hafalan.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hafalan ${CurrentChildService.currentChild!.namaPanggilan}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: daftarHafalan.length,
                        itemBuilder: (context, index) {
                          final hafalan = daftarHafalan[index];

                          return ListTile(
                            leading: const Icon(
                              Icons.menu_book,
                              color: Colors.green,
                            ),
                            title: Text(hafalan.namaSurat),
                            subtitle: Text(
                              "Ayat : ${hafalan.ayat}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddHafalanScreen(
                                          hafalan: hafalan,
                                        ),
                                      ),
                                    );

                                    if (result == true) {
                                      setState(() {
                                        _loadData();
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    if (hafalan.id == null) return;

                                    await repository.delete(hafalan.id!);

                                    setState(() {
                                      _loadData();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}