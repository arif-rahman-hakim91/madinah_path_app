import 'package:flutter/material.dart';

import '../models/guardian.dart';
import '../repositories/guardian_repository.dart';
import 'guardian_screen.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  final repository = GuardianRepository();

  Guardian? guardian;

  @override
  void initState() {
    super.initState();
    loadGuardian();
  }

  Future<void> loadGuardian() async {
    final data = await repository.getGuardian();

    if (!mounted) return;

    setState(() {
      guardian = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keluarga"),
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
                  const Row(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Colors.green,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Data Wali",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Nama"),
                    subtitle: Text(
                      guardian?.namaLengkap ?? "Belum diisi",
                    ),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text("Peran"),
                    subtitle: Text(
                      guardian?.jenisKelamin ?? "Belum diisi",
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GuardianScreen(),
                          ),
                        );

                        await loadGuardian();
                      },
                      child: const Text("Kelola Data Wali"),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.child_care,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Anak",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "Belum ada data anak",
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Tambah Anak"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}