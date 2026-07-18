import 'dart:io';

import 'package:flutter/material.dart';

import '../services/photo_service.dart';
import '../repositories/child_repository.dart';
import '../services/current_child_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final photoService = PhotoService();

  File? selectedImage;

  Future<void> pickPhoto() async {
    final image = await photoService.pickImage();

    if (image == null) return;

    final currentChild = CurrentChildService.currentChild;

    if (currentChild == null) return;

    final updatedChild = currentChild.copyWith(
      foto: image.path,
      updatedAt: DateTime.now(),
    );

    await ChildRepository().update(updatedChild);

    CurrentChildService.refreshCurrentChild(updatedChild);

    if (!mounted) return;

    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickPhoto,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : CurrentChildService.currentChild?.foto != null
                          ? FileImage(
                        File(
                          CurrentChildService.currentChild!.foto!,
                        ),
                      )
                          : null,
                      child: selectedImage == null &&
                          CurrentChildService.currentChild?.foto == null
                          ? const Icon(
                        Icons.child_care,
                        size: 45,
                      )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Ketuk foto untuk mengganti",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Nama Anak",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text("Tingkat TK-A"),

                  const SizedBox(height: 20),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text("Progress Hafalan"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.workspace_premium),
                    title: const Text("Pencapaian"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
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