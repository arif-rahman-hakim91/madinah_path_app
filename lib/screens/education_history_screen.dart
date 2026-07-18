import 'package:flutter/material.dart';

import '../models/education.dart';
import '../repositories/education_repository.dart';
import '../services/current_child_service.dart';
import 'add_education_screen.dart';

class EducationHistoryScreen extends StatefulWidget {
  const EducationHistoryScreen({super.key});

  @override
  State<EducationHistoryScreen> createState() =>
      _EducationHistoryScreenState();
}

class _EducationHistoryScreenState
    extends State<EducationHistoryScreen> {

  final repository = EducationRepository();

  late Future<List<Education>> history;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
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
        title: const Text("Riwayat Pendidikan"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEducationScreen(),
            ),
          );

          if (result == true && mounted) {
            setState(() {
              loadData();
            });
          }
        },
      ),

      body: FutureBuilder<List<Education>>(
        future: history,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada riwayat pendidikan.",
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {

              final item = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Column(
                        children: [

                          const Icon(
                            Icons.school,
                            color: Colors.green,
                          ),

                          Container(
                            width: 2,
                            height: 70,
                            color: Colors.green.shade300,
                          ),
                        ],
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              item.jenjang,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(item.namaSekolah),

                            Text("Guru : ${item.namaGuru}"),

                            if (item.catatan.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(item.catatan),
                              ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                        builder: (_) => AddEducationScreen(
                                          education: item,
                                        ),
                                      ),
                                    );

                                    if (result == true && mounted) {
                                      setState(loadData);
                                    }
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {

                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text("Hapus"),
                                        content: const Text(
                                          "Yakin ingin menghapus riwayat pendidikan ini?",
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
                                      ),
                                    );

                                    if (confirm == true) {
                                      await repository.delete(item.id!);

                                      if (!mounted) return;

                                      setState(loadData);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}