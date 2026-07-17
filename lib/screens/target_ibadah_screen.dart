import 'package:flutter/material.dart';

import '../models/target_ibadah.dart';
import '../repositories/target_ibadah_repository.dart';
import '../services/current_child_service.dart';

class TargetIbadahScreen extends StatefulWidget {
  const TargetIbadahScreen({super.key});

  @override
  State<TargetIbadahScreen> createState() => _TargetIbadahScreenState();
}

class _TargetIbadahScreenState extends State<TargetIbadahScreen> {
  final subuhController = TextEditingController();
  final dzuhurController = TextEditingController();
  final asharController = TextEditingController();
  final maghribController = TextEditingController();
  final isyaController = TextEditingController();
  final tilawahController = TextEditingController();
  final dzikirController = TextEditingController();

  final repository = TargetIbadahRepository();

  TargetIbadah? target;

  @override
  void initState() {
    super.initState();
    loadTarget();
  }

  Future<void> loadTarget() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final data = await repository.getTarget(child.id!);

    if (!mounted) return;

    if (data == null) return;

    setState(() {
      target = data;

      subuhController.text = data.subuh.toString();
      dzuhurController.text = data.dzuhur.toString();
      asharController.text = data.ashar.toString();
      maghribController.text = data.maghrib.toString();
      isyaController.text = data.isya.toString();
      tilawahController.text = data.tilawah.toString();
      dzikirController.text = data.dzikir.toString();
    });
  }

  @override
  void dispose() {
    subuhController.dispose();
    dzuhurController.dispose();
    asharController.dispose();
    maghribController.dispose();
    isyaController.dispose();
    tilawahController.dispose();
    dzikirController.dispose();

    super.dispose();
  }

  Widget buildField(
      String label,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> saveTarget() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    if (target == null) {
      await repository.save(
        TargetIbadah(
          childId: child.id!,
          subuh: int.tryParse(subuhController.text) ?? 0,
          dzuhur: int.tryParse(dzuhurController.text) ?? 0,
          ashar: int.tryParse(asharController.text) ?? 0,
          maghrib: int.tryParse(maghribController.text) ?? 0,
          isya: int.tryParse(isyaController.text) ?? 0,
          tilawah: int.tryParse(tilawahController.text) ?? 0,
          dzikir: int.tryParse(dzikirController.text) ?? 0,
        ),
      );
    } else {
      await repository.update(
        TargetIbadah(
          id: target!.id,
          childId: target!.childId,
          subuh: int.tryParse(subuhController.text) ?? 0,
          dzuhur: int.tryParse(dzuhurController.text) ?? 0,
          ashar: int.tryParse(asharController.text) ?? 0,
          maghrib: int.tryParse(maghribController.text) ?? 0,
          isya: int.tryParse(isyaController.text) ?? 0,
          tilawah: int.tryParse(tilawahController.text) ?? 0,
          dzikir: int.tryParse(dzikirController.text) ?? 0,
        ),
      );
    }

    await loadTarget();
  }

  @override
  Widget build(BuildContext context) {
    if (CurrentChildService.currentChild == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Target Ibadah"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            "Silakan pilih anak terlebih dahulu.",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Target Ibadah"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildField("Target Subuh", subuhController),
          buildField("Target Dzuhur", dzuhurController),
          buildField("Target Ashar", asharController),
          buildField("Target Maghrib", maghribController),
          buildField("Target Isya", isyaController),
          buildField("Target Tilawah", tilawahController),
          buildField("Target Dzikir", dzikirController),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await saveTarget();

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Target ibadah berhasil disimpan.",
                    ),
                  ),
                );
              },
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}