import 'package:flutter/material.dart';

import '../models/jadwal_sekolah.dart';
import '../repositories/jadwal_sekolah_repository.dart';
import '../services/current_child_service.dart';
import 'tambah_jadwal_sekolah_screen.dart';

class JadwalSekolahScreen extends StatefulWidget {
  const JadwalSekolahScreen({
    super.key,
  });

  @override
  State<JadwalSekolahScreen> createState() =>
      _JadwalSekolahScreenState();
}

class _JadwalSekolahScreenState
    extends State<JadwalSekolahScreen> {
  final repository = JadwalSekolahRepository();

  List<JadwalSekolah> jadwal = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  Future<void> loadJadwal() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final result = await repository.getAll(
      child.id!,
    );

    if (!mounted) return;

    setState(() {
      jadwal = result;
      isLoading = false;
    });
  }

  String formatTanggal(DateTime tanggal) {
    const namaHari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    const namaBulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return "${namaHari[tanggal.weekday - 1]}, "
        "${tanggal.day} "
        "${namaBulan[tanggal.month - 1]} "
        "${tanggal.year}";
  }

  @override
  Widget build(BuildContext context) {
    final child = CurrentChildService.currentChild;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const TambahJadwalSekolahScreen(),
            ),
          );

          if (result == true) {
            await loadJadwal();
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Jadwal Sekolah"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : child == null
          ? const Center(
        child: Text(
          "Silakan pilih anak terlebih dahulu.",
        ),
      )
          : jadwal.isEmpty
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "Belum ada jadwal sekolah.",
            textAlign: TextAlign.center,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jadwal.length,
        itemBuilder: (context, index) {
          final item = jadwal[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 8,
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
              leading: CircleAvatar(
                radius: 18,
                backgroundColor:
                Colors.green.shade50,
                child: Icon(
                  Icons.school_outlined,
                  size: 20,
                  color: Colors.green.shade700,
                ),
              ),
              title: Text(
                item.judul,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "${item.kategori} • "
                    "${formatTanggal(item.tanggal)}",
              ),
            ),
          );
        },
      ),
    );
  }
}