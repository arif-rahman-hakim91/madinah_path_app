import 'package:flutter/material.dart';

import '../models/child.dart';
import '../repositories/child_repository.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final repository = ChildRepository();

  final namaLengkapController = TextEditingController();
  final namaPanggilanController = TextEditingController();

  DateTime? tanggalLahir;

  String jenisKelamin = "Laki-laki";

  @override
  void dispose() {
    namaLengkapController.dispose();
    namaPanggilanController.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (hasil == null) return;

    setState(() {
      tanggalLahir = hasil;
    });
  }

  Future<void> simpanChild() async {
    if (namaLengkapController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nama lengkap harus diisi."),
        ),
      );
      return;
    }

    if (namaPanggilanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nama panggilan harus diisi."),
        ),
      );
      return;
    }

    if (tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tanggal lahir harus dipilih."),
        ),
      );
      return;
    }

    final child = Child(
      guardianId: 1,
      namaLengkap: namaLengkapController.text.trim(),
      namaPanggilan: namaPanggilanController.text.trim(),
      tanggalLahir: tanggalLahir!,
      jenisKelamin: jenisKelamin,
      foto: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await repository.add(child);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data anak berhasil disimpan."),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Anak"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: namaLengkapController,
            decoration: const InputDecoration(
              labelText: "Nama Lengkap",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: namaPanggilanController,
            decoration: const InputDecoration(
              labelText: "Nama Panggilan",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            initialValue: jenisKelamin,
            decoration: const InputDecoration(
              labelText: "Jenis Kelamin",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: "Laki-laki",
                child: Text("Laki-laki"),
              ),
              DropdownMenuItem(
                value: "Perempuan",
                child: Text("Perempuan"),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                jenisKelamin = value;
              });
            },
          ),

          const SizedBox(height: 15),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.grey),
            ),
            title: Text(
              tanggalLahir == null
                  ? "Pilih Tanggal Lahir"
                  : "${tanggalLahir!.day}/${tanggalLahir!.month}/${tanggalLahir!.year}",
            ),
            trailing: const Icon(Icons.calendar_month),
            onTap: pilihTanggal,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: simpanChild,
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}