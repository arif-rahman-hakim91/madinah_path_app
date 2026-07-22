import 'package:flutter/material.dart';

import '../models/guardian.dart';

class ProfileGuardianCard extends StatelessWidget {
  final Guardian? guardian;
  final VoidCallback onPressed;

  const ProfileGuardianCard({
    super.key,
    required this.guardian,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profil Wali",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              guardian == null
                  ? "Silakan lengkapi data wali terlebih dahulu."
                  : guardian!.namaLengkap,
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  guardian == null
                      ? "Tambah Data Wali"
                      : "Edit Data Wali",
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              guardian == null
                  ? "-"
                  : guardian!.jenisKelamin,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}