import 'package:flutter/material.dart';

import '../models/guardian.dart';
import '../repositories/guardian_repository.dart';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  final namaLengkapController = TextEditingController();
  final namaPanggilanController = TextEditingController();
  final emailController = TextEditingController();
  final nomorHpController = TextEditingController();
  final pinController = TextEditingController();

  String jenisKelamin = "Ummi";

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

    if (data == null) return;

    setState(() {
      guardian = data;

      namaLengkapController.text = data.namaLengkap;
      namaPanggilanController.text = data.namaPanggilan;
      emailController.text = data.email ?? "";
      nomorHpController.text = data.nomorHp ?? "";
      pinController.text = data.pin ?? "";
      jenisKelamin = data.jenisKelamin;
    });
  }

  Future<void> saveGuardian() async {
    final now = DateTime.now();

    if (guardian == null) {
      await repository.save(
        Guardian(
          namaLengkap: namaLengkapController.text,
          namaPanggilan: namaPanggilanController.text,
          jenisKelamin: jenisKelamin,
          email: emailController.text,
          nomorHp: nomorHpController.text,
          pin: pinController.text,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else {
      await repository.update(
        Guardian(
          id: guardian!.id,
          namaLengkap: namaLengkapController.text,
          namaPanggilan: namaPanggilanController.text,
          jenisKelamin: jenisKelamin,
          email: emailController.text,
          nomorHp: nomorHpController.text,
          foto: guardian!.foto,
          pin: pinController.text,
          createdAt: guardian!.createdAt,
          updatedAt: now,
        ),
      );
    }

    await loadGuardian();
  }

  Widget buildField(
      String label,
      TextEditingController controller, {
        bool obscure = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    namaPanggilanController.dispose();
    emailController.dispose();
    nomorHpController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Wali"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildField(
            "Nama Lengkap",
            namaLengkapController,
          ),

          buildField(
            "Nama Panggilan",
            namaPanggilanController,
          ),

          DropdownButtonFormField<String>(
            initialValue: jenisKelamin,
            decoration: const InputDecoration(
              labelText: "Peran",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: "Ummi",
                child: Text("Ummi"),
              ),
              DropdownMenuItem(
                value: "Abi",
                child: Text("Abi"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                jenisKelamin = value!;
              });
            },
          ),

          const SizedBox(height: 15),

          buildField(
            "Email",
            emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          buildField(
            "Nomor HP",
            nomorHpController,
            keyboardType: TextInputType.phone,
          ),

          buildField(
            "PIN",
            pinController,
            obscure: true,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await saveGuardian();

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Data wali berhasil disimpan.",
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