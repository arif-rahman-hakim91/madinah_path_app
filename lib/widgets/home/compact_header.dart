import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/guardian.dart';
import '../../services/current_child_service.dart';

class CompactHeader extends StatelessWidget {
  final Guardian? guardian;
  final VoidCallback onChangeChild;

  const CompactHeader({
    super.key,
    required this.guardian,
    required this.onChangeChild,
  });

  @override
  Widget build(BuildContext context) {
    final child = CurrentChildService.currentChild;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green.shade100,
          backgroundImage: guardian?.foto != null
              ? FileImage(File(guardian!.foto!))
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
              color: Colors.green,
            ),
          )
              : null,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                guardian?.namaPanggilan ??
                    "Pengguna",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 0),

              const Text(
                "ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),

        ActionChip(
          avatar: const Icon(
            Icons.school,
            size: 14,
          ),
          label: Text(
            child?.namaPanggilan ?? "Pilih Anak",
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 0,
          ),
          visualDensity: const VisualDensity(
            horizontal: -3,
            vertical: -3,
          ),
          materialTapTargetSize:
          MaterialTapTargetSize.shrinkWrap,
          onPressed: onChangeChild,
        )
      ],
    );
  }
}