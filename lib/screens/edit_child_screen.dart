import 'package:flutter/material.dart';

import '../models/child.dart';
import '../repositories/child_repository.dart';

class EditChildScreen extends StatefulWidget {
  final Child child;

  const EditChildScreen({
    super.key,
    required this.child,
  });

  @override
  State<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends State<EditChildScreen> {
  final repository = ChildRepository();

  late TextEditingController namaLengkapController;
  late TextEditingController namaPanggilanController;

  late DateTime tanggalLahir;

  late String jenisKelamin;

  @override
  void initState() {
    super.initState();

    namaLengkapController =
        TextEditingController(text: widget.child.namaLengkap);

    namaPanggilanController =
        TextEditingController(text: widget.child.namaPanggilan);

    tanggalLahir = widget.child.tanggalLahir;
    jenisKelamin = widget.child.jenisKelamin;
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    namaPanggilanController.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: tanggalLahir,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (hasil == null) return;

    setState(() {
      tanggalLahir = hasil;
    });
  }

  Future<void> updateChild() async {
    final child = Child(
      id: widget.child.id,
      guardianId: widget.child.guardianId,
      namaLengkap: namaLengkapController.text,
      namaPanggilan: namaPanggilanController.text,
      tanggalLahir: tanggalLahir,
      jenisKelamin: jenisKelamin,
      foto: widget.child.foto,
      createdAt: widget.child.createdAt,
      updatedAt: DateTime.now(),
    );

    await repository.update(child);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Anak"),
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
              "${tanggalLahir.day}/${tanggalLahir.month}/${tanggalLahir.year}",
            ),
            trailing: const Icon(Icons.calendar_month),
            onTap: pilihTanggal,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: updateChild,
              child: const Text("Update"),
            ),
          ),
        ],
      ),
    );
  }
}