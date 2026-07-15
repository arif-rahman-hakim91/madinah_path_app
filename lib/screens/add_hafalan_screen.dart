import 'package:flutter/material.dart';
import '../models/hafalan.dart';
import '../repositories/hafalan_repository.dart';

class AddHafalanScreen extends StatefulWidget {
  final Hafalan? hafalan;
  const AddHafalanScreen({
    super.key,
    this.hafalan,});

  @override
  State<AddHafalanScreen> createState() => _AddHafalanScreenState();
}

class _AddHafalanScreenState extends State<AddHafalanScreen> {
  final TextEditingController suratController = TextEditingController();
  final TextEditingController ayatController = TextEditingController();
  final repository = HafalanRepository();

  @override
  void initState() {
    super.initState();

    if (widget.hafalan != null) {
      suratController.text = widget.hafalan!.namaSurat;
      ayatController.text = widget.hafalan!.ayat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Hafalan"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama Surat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: suratController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Contoh: Al-Fatihah",
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Ayat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: ayatController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Contoh: 1 - 7",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (suratController.text.isEmpty ||
                      ayatController.text.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Nama surat dan ayat harus diisi.",
                        ),
                      ),
                    );

                    return;
                  }
                  if (widget.hafalan == null) {

                    await repository.add(
                      Hafalan(
                        namaSurat: suratController.text,
                        ayat: ayatController.text,
                      ),
                    );

                  } else {

                    await repository.update(
                      Hafalan(
                        id: widget.hafalan!.id,
                        namaSurat: suratController.text,
                        ayat: ayatController.text,
                      ),
                    );

                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}