import 'package:flutter/material.dart';

import '../models/target.dart';
import '../repositories/target_repository.dart';
import '../services/current_child_service.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final repository = TargetRepository();

  List<Target> targets = [];

  @override
  void initState() {
    super.initState();
    loadTargets();
  }

  Future<void> loadTargets() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final result = await repository.getByDate(
      childId: child.id!,
      date: DateTime.now(),
    );

    if (!mounted) return;

    setState(() {
      targets = result;
    });
  }

  Future<void> toggleTarget(Target target) async {
    final updated = target.copyWith(
      isCompleted: !target.isCompleted,
      updatedAt: DateTime.now(),
    );

    await repository.update(updated);

    await loadTargets();
  }

  int get completedTarget {
    return targets.where((e) => e.isCompleted).length;
  }

  double get progress {
    if (targets.isEmpty) return 0;

    return completedTarget / targets.length;
  }

  Future<void> addTarget() async {
    await showTargetForm();
  }

  Future<void> editTarget(Target target) async {
    await showTargetForm(
      target: target,
    );
  }

  Future<void> deleteTarget(Target target) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Target"),
          content: Text(
            "Apakah Anda yakin ingin menghapus '${target.nama}'?",
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

    if (result != true) return;

    await repository.delete(target.id!);

    await loadTargets();
  }

  Future<void> saveTarget(Target target) async {
    if (target.id == null) {
      await repository.add(target);
    } else {
      await repository.update(target);
    }

    await loadTargets();
  }

  Future<void> showTargetForm({
    Target? target,
  }) async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final controller = TextEditingController(
      text: target?.nama ?? "",
    );

    String kategori = target?.kategori ?? "Hafalan";

    final result = await showDialog<Target>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                target == null
                    ? "Tambah Target"
                    : "Edit Target",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: "Nama Target",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    initialValue: kategori,
                    decoration: const InputDecoration(
                      labelText: "Kategori",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Hafalan",
                        child: Text("Hafalan"),
                      ),
                      DropdownMenuItem(
                        value: "Ibadah",
                        child: Text("Ibadah"),
                      ),
                      DropdownMenuItem(
                        value: "Adab",
                        child: Text("Adab"),
                      ),
                      DropdownMenuItem(
                        value: "Doa",
                        child: Text("Doa"),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        kategori = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      Target(
                        id: target?.id,
                        childId: child.id!,
                        nama: controller.text.trim(),
                        kategori: kategori,
                        isCompleted:
                        target?.isCompleted ?? false,
                        targetDate:
                        target?.targetDate ??
                            DateTime.now(),
                        createdAt:
                        target?.createdAt ??
                            DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == null) return;

    await saveTarget(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target Harian"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Target Hari Ini",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$completedTarget/${targets.length} Target • ${(progress * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (targets.isEmpty)
                    const Center(
                      child: Text(
                        "Belum ada target hari ini.",
                      ),
                    ),
                  ...targets.map(
                        (target) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Checkbox(
                          value: target.isCompleted,
                          onChanged: (value) async {
                            await toggleTarget(target);
                          },
                        ),
                        title: Text(
                          target.nama,
                          style: TextStyle(
                            decoration: target.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(target.kategori),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            switch (value) {
                              case "edit":
                                await editTarget(target);
                                break;

                              case "delete":
                                await deleteTarget(target);
                                break;
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: "edit",
                              child: Text("Edit"),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Text("Hapus"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTarget,
        child: const Icon(Icons.add),
      ),
    );
  }
}