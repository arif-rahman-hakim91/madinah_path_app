import 'package:flutter/material.dart';

class AddHafalanScreen extends StatefulWidget {
  const AddHafalanScreen({super.key});

  @override
  State<AddHafalanScreen> createState() => _AddHafalanScreenState();
}

class _AddHafalanScreenState extends State<AddHafalanScreen> {
  final TextEditingController suratController = TextEditingController();
  final TextEditingController ayatController = TextEditingController();

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
                onPressed: () {
                  debugPrint(suratController.text);
                  debugPrint(ayatController.text);

                  Navigator.pop(context);
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