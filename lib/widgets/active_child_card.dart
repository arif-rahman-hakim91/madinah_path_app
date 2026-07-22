import 'dart:io';

import 'package:flutter/material.dart';

import '../services/current_child_service.dart';

class ActiveChildCard extends StatelessWidget {
  final VoidCallback onChangeChild;

  const ActiveChildCard({
    super.key,
    required this.onChangeChild,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.child_care,
                  size: 40,
                  color: Colors.green,
                ),
                SizedBox(width: 12),
                Text(
                  "Anak Aktif",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage:
                CurrentChildService.currentChild?.foto != null
                    ? FileImage(
                  File(
                    CurrentChildService.currentChild!.foto!,
                  ),
                )
                    : null,
                child: CurrentChildService.currentChild?.foto == null
                    ? const Icon(Icons.child_care)
                    : null,
              ),
              title: const Text("Nama"),
              subtitle: Text(
                CurrentChildService.currentChild?.namaLengkap ??
                    "Belum memilih anak",
              ),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.workspace_premium),
              title: const Text("Nama Panggilan"),
              subtitle: Text(
                CurrentChildService.currentChild?.namaPanggilan ?? "-",
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onChangeChild,
                child: const Text("Ganti Anak"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}