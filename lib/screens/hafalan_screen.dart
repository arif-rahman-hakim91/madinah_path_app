import 'package:flutter/material.dart';

import '../models/hafalan.dart';
import '../repositories/hafalan_repository.dart';
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
    _hafalanFuture = repository.getAll();
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
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddHafalanScreen(),
            ),
          );

          setState(() {
            _loadData();
          });
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
                    const Text(
                      "Hafalan Hari Ini",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...daftarHafalan.map(
                          (hafalan) => ListTile(
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
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddHafalanScreen(
                                      hafalan: hafalan,
                                    ),
                                  ),
                                );

                                setState(() {
                                  _loadData();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                if (hafalan.id != null) {
                                  await repository.delete(hafalan.id!);

                                  setState(() {
                                    _loadData();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
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