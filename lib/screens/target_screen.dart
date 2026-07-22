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
    final bool completed = !target.isCompleted;

    String status = target.status;

    if (completed) {
      switch (target.status) {
        case "Belum Dipelajari":
          status = "Belum Lancar";
          break;

        case "Belum Lancar":
          status = "Cukup";
          break;

        case "Cukup":
          status = "Lancar";
          break;

        case "Lancar":
          status = "Mutqin";
          break;

        case "Mutqin":
          status = "Mutqin";
          break;
      }
    }

    final updated = target.copyWith(
      isCompleted: completed,
      status: status,
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
    String status =
        target?.status ?? "Belum Dipelajari";

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
                      // =========================
                      // AL-QUR'AN
                      // =========================
                      DropdownMenuItem(
                        value: "Murajaah",
                        child: Text("📖 Murajaah"),
                      ),
                      DropdownMenuItem(
                        value: "Hafalan",
                        child: Text("📖 Hafalan"),
                      ),
                      DropdownMenuItem(
                        value: "Mutqin",
                        child: Text("📖 Mutqin"),
                      ),
                      DropdownMenuItem(
                        value: "Tilawah",
                        child: Text("📖 Tilawah"),
                      ),

                      // =========================
                      // IBADAH
                      // =========================
                      DropdownMenuItem(
                        value: "Shalat",
                        child: Text("🕌 Shalat"),
                      ),
                      DropdownMenuItem(
                        value: "Dzikir",
                        child: Text("🕌 Dzikir"),
                      ),
                      DropdownMenuItem(
                        value: "Doa",
                        child: Text("🕌 Doa"),
                      ),
                      DropdownMenuItem(
                        value: "Wudhu",
                        child: Text("🕌 Wudhu"),
                      ),

                      // =========================
                      // ILMU ISLAM
                      // =========================
                      DropdownMenuItem(
                        value: "Hadits",
                        child: Text("📚 Hadits"),
                      ),
                      DropdownMenuItem(
                        value: "Aqidah",
                        child: Text("📚 Aqidah"),
                      ),
                      DropdownMenuItem(
                        value: "Fiqih",
                        child: Text("📚 Fiqih"),
                      ),
                      DropdownMenuItem(
                        value: "Sirah",
                        child: Text("📚 Sirah"),
                      ),
                      DropdownMenuItem(
                        value: "Asmaul Husna",
                        child: Text("📚 Asmaul Husna"),
                      ),

                      // =========================
                      // ADAB
                      // =========================
                      DropdownMenuItem(
                        value: "Adab",
                        child: Text("🤲 Adab"),
                      ),
                      DropdownMenuItem(
                        value: "Akhlak",
                        child: Text("🤲 Akhlak"),
                      ),

                      // =========================
                      // BAHASA
                      // =========================
                      DropdownMenuItem(
                        value: "Huruf Hijaiyah",
                        child: Text("🔤 Huruf Hijaiyah"),
                      ),
                      DropdownMenuItem(
                        value: "Iqra",
                        child: Text("🔤 Iqra"),
                      ),
                      DropdownMenuItem(
                        value: "Bahasa Arab",
                        child: Text("🔤 Bahasa Arab"),
                      ),
                      DropdownMenuItem(
                        value: "Huruf Latin",
                        child: Text("🔤 Huruf Latin"),
                      ),
                      DropdownMenuItem(
                        value: "Membaca",
                        child: Text("🔤 Membaca"),
                      ),

                      // =========================
                      // KOGNITIF
                      // =========================
                      DropdownMenuItem(
                        value: "Berhitung",
                        child: Text("🧠 Berhitung"),
                      ),
                      DropdownMenuItem(
                        value: "Warna",
                        child: Text("🧠 Mengenal Warna"),
                      ),
                      DropdownMenuItem(
                        value: "Bentuk",
                        child: Text("🧠 Mengenal Bentuk"),
                      ),
                      DropdownMenuItem(
                        value: "Pola",
                        child: Text("🧠 Mengenal Pola"),
                      ),

                      // =========================
                      // MOTORIK
                      // =========================
                      DropdownMenuItem(
                        value: "Motorik Halus",
                        child: Text("✂️ Motorik Halus"),
                      ),
                      DropdownMenuItem(
                        value: "Motorik Kasar",
                        child: Text("🏃 Motorik Kasar"),
                      ),

                      // =========================
                      // LIFE SKILL
                      // =========================
                      DropdownMenuItem(
                        value: "Kemandirian",
                        child: Text("🏡 Kemandirian"),
                      ),
                      DropdownMenuItem(
                        value: "Life Skill",
                        child: Text("🏡 Life Skill"),
                      ),
                      DropdownMenuItem(
                        value: "Proyek Amal",
                        child: Text("❤️ Proyek Amal"),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        kategori = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(
                      labelText: "Status Belajar",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Belum Dipelajari",
                        child: Text("Belum Dipelajari"),
                      ),
                      DropdownMenuItem(
                        value: "Belum Lancar",
                        child: Text("Belum Lancar"),
                      ),
                      DropdownMenuItem(
                        value: "Cukup",
                        child: Text("Cukup"),
                      ),
                      DropdownMenuItem(
                        value: "Lancar",
                        child: Text("Lancar"),
                      ),
                      DropdownMenuItem(
                        value: "Mutqin",
                        child: Text("Mutqin"),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        status = value!;
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
                        status: status,
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