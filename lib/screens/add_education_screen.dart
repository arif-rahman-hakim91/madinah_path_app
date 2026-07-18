import 'package:flutter/material.dart';

import '../models/education.dart';
import '../repositories/education_repository.dart';
import '../services/current_child_service.dart';

class AddEducationScreen extends StatefulWidget {
  final Education? education;

  const AddEducationScreen({
    super.key,
    this.education,
  });

  @override
  State<AddEducationScreen> createState() =>
      _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final jenjangController = TextEditingController();
  final sekolahController = TextEditingController();
  final guruController = TextEditingController();
  final catatanController = TextEditingController();

  final repository = EducationRepository();

  @override
  void initState() {
    super.initState();

    if (widget.education != null) {
      jenjangController.text = widget.education!.jenjang;
      sekolahController.text = widget.education!.namaSekolah;
      guruController.text = widget.education!.namaGuru;
      catatanController.text = widget.education!.catatan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.education == null
              ? "Tambah Riwayat Pendidikan"
              : "Edit Riwayat Pendidikan",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          TextField(
            controller: jenjangController,
            decoration: const InputDecoration(
              labelText: "Jenjang",
              border: OutlineInputBorder(),
              hintText: "Contoh: SD, SMP, SMA",
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: sekolahController,
            decoration: const InputDecoration(
              labelText: "Nama Sekolah",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: guruController,
            decoration: const InputDecoration(
              labelText: "Nama Guru",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: catatanController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Catatan",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final child = CurrentChildService.currentChild;

                if (child == null) {
                  return;
                }

                if (jenjangController.text.isEmpty ||
                    sekolahController.text.isEmpty ||
                    guruController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Semua data wajib diisi.",
                      ),
                    ),
                  );
                  return;
                }

                if (widget.education == null) {
                  await repository.add(
                    Education(
                      childId: child.id!,
                      jenjang: jenjangController.text,
                      namaSekolah: sekolahController.text,
                      namaGuru: guruController.text,
                      catatan: catatanController.text,
                      tanggalMulai: DateTime.now(),
                      tanggalSelesai: null,
                    ),
                  );
                } else {
                  await repository.update(
                    Education(
                      id: widget.education!.id,
                      childId: child.id!,
                      jenjang: jenjangController.text,
                      namaSekolah: sekolahController.text,
                      namaGuru: guruController.text,
                      catatan: catatanController.text,
                      tanggalMulai: widget.education!.tanggalMulai,
                      tanggalSelesai: widget.education!.tanggalSelesai,
                    ),
                  );
                }

                if (!context.mounted) return;

                Navigator.pop(context, true);
              },
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    jenjangController.dispose();
    sekolahController.dispose();
    guruController.dispose();
    catatanController.dispose();

    super.dispose();
  }
}