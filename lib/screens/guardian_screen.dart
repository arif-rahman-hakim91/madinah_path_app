import 'dart:io';

import 'package:flutter/material.dart';

import '../models/guardian.dart';
import '../repositories/guardian_repository.dart';
import '../services/photo_service.dart';

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

  final repository = GuardianRepository();
  final photoService = PhotoService();

  Guardian? guardian;

  File? selectedImage;

  String jenisKelamin = "Umma";

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
      if (data.foto != null) {
        selectedImage = File(data.foto!);
      }

      namaLengkapController.text = data.namaLengkap;
      namaPanggilanController.text = data.namaPanggilan;
      emailController.text = data.email ?? "";
      nomorHpController.text = data.nomorHp ?? "";
      pinController.text = data.pin ?? "";
      jenisKelamin = data.jenisKelamin;

    });
  }

  Future<void> pickPhoto() async {
    final image = await photoService.pickImage();

    if (image == null) return;

    setState(() {
      selectedImage = image;
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
          foto: selectedImage?.path,
          pin: pinController.text,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else {
      final updatedGuardian = guardian!.copyWith(
        namaLengkap: namaLengkapController.text,
        namaPanggilan: namaPanggilanController.text,
        jenisKelamin: jenisKelamin,
        email: emailController.text,
        nomorHp: nomorHpController.text,
        foto: selectedImage?.path,
        pin: pinController.text,
        updatedAt: now,
      );

      await repository.update(updatedGuardian);
    }

    await loadGuardian();

    if (!mounted) return;

    Navigator.pop(context, true);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Wali"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: GestureDetector(
              onTap: pickPhoto,
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                selectedImage != null ? FileImage(selectedImage!) : null,
                child: selectedImage == null
                    ? const Icon(
                  Icons.person,
                  size: 55,
                )
                    : null,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              "Ketuk foto untuk mengganti",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 20),

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
    namaLengkapController.dispose();
    namaPanggilanController.dispose();
    emailController.dispose();
    nomorHpController.dispose();
    pinController.dispose();
    super.dispose();
  }
}