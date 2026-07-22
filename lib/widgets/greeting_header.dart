import 'dart:io';

import 'package:flutter/material.dart';

import '../models/guardian.dart';

class GreetingHeader extends StatelessWidget {
  final Guardian? guardian;

  const GreetingHeader({
    super.key,
    required this.guardian,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.green.shade100,
              backgroundImage: guardian?.foto != null
                  ? FileImage(
                File(guardian!.foto!),
              )
                  : null,
              child: guardian?.foto == null
                  ? Text(
                guardian == null
                    ? "?"
                    : guardian!.namaPanggilan
                    .substring(0, 1)
                    .toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              )
                  : null,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guardian == null
                        ? "ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ"
                        : "ٱلسَّلَامُ عَلَيْكُمْ ${guardian!.jenisKelamin}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    guardian == null
                        ? "Ahlan Wa Sahlan"
                        : "Ahlan Wa Sahlan,\n${guardian!.namaPanggilan}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Text(
          guardian == null
              ? "Lengkapi data wali untuk mulai menggunakan aplikasi."
              : "Pantau perkembangan hafalan, ibadah, dan target harian anak.",
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}