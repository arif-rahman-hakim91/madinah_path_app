import 'package:flutter/material.dart';

import '../models/jadwal_sekolah.dart';
import '../repositories/jadwal_sekolah_repository.dart';
import '../services/current_child_service.dart';
import 'package:image_picker/image_picker.dart';

import '../services/jadwal_ocr_service.dart';
import '../services/jadwal_parser_service.dart';

import '../models/target.dart';
import '../repositories/target_repository.dart';

import '../models/daily_target.dart';
import '../repositories/daily_target_repository.dart';

class TambahJadwalSekolahScreen extends StatefulWidget {
  const TambahJadwalSekolahScreen({
    super.key,
  });

  @override
  State<TambahJadwalSekolahScreen> createState() =>
      _TambahJadwalSekolahScreenState();
}

class _TambahJadwalSekolahScreenState
    extends State<TambahJadwalSekolahScreen> {
  final repository = JadwalSekolahRepository();
  final ImagePicker imagePicker = ImagePicker();
  final TargetRepository targetRepository =
  TargetRepository();
  final DailyTargetRepository dailyTargetRepository =
  DailyTargetRepository();

  Future<void> editMateri(
      JadwalParserItem item,
      ) async {
    final controller = TextEditingController(
      text: item.judul,
    );

    final hasil = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Materi"),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Materi",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();

                if (text.isEmpty) return;

                Navigator.pop(context, text);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (hasil == null || hasil.isEmpty) {
      return;
    }

    setState(() {
      item.judul = hasil;
    });
  }

  Future<void> tambahKategori() async {
    kategoriController.clear();

    final hasil = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Kategori"),
          content: TextField(
            controller: kategoriController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Nama kategori",
              hintText: "Contoh: Bahasa Arab",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final nama =
                kategoriController.text.trim();

                if (nama.isEmpty) return;

                Navigator.pop(context, nama);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );

    if (hasil == null || hasil.isEmpty) return;

    if (!kategoriList.contains(hasil)) {
      setState(() {
        kategoriList.add(hasil);
        kategori = hasil;
      });
    } else {
      setState(() {
        kategori = hasil;
      });
    }
  }

  final JadwalOcrService ocrService =
  JadwalOcrService();

  final JadwalParserService parserService =
  JadwalParserService();

  String? hasilScan;

  List<JadwalParserItem> hasilParser = [];

  bool isScanning = false;

  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();

  DateTime? tanggal;

  String kategori = "Hafalan";

  bool isSaving = false;

  final List<String> kategoriList = [
    "Hafalan",
    "Iqra",
    "Huruf",
    "Angka",
    "Doa",
    "Mufradat",
    "Adab",
    "Kegiatan",
  ];

  final TextEditingController kategoriController =
  TextEditingController();

  @override
  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    kategoriController.dispose();

    ocrService.dispose();

    super.dispose();
  }

  Future<void> scanFoto(
      ImageSource source,
      ) async {
    final image = await imagePicker.pickImage(
      source: source,
    );

    if (image == null) return;

    setState(() {
      isScanning = true;
      hasilScan = null;
    });

    try {
      final text = await ocrService.scanImage(
        image.path,
      );

      if (!mounted) return;

      final parsed = parserService.parse(text);

      if (!mounted) return;

      setState(() {
        hasilScan = text;
        hasilParser = parsed;
        isScanning = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isScanning = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Gagal membaca foto: $e",
          ),
        ),
      );
    }
  }

  Future<void> pilihTanggal() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: tanggal ?? DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(2035),
    );

    if (selected == null) return;

    setState(() {
      tanggal = selected;
    });
  }

  Future<void> simpanHasilScan() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return;
    }

    if (hasilParser.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Belum ada materi yang dapat disimpan.",
          ),
        ),
      );

      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final now = DateTime.now();

      for (final item in hasilParser) {
        await repository.add(
          JadwalSekolah(
            childId: child.id!,
            tanggal: tanggal ?? now,
            kategori: item.kategori,
            judul: item.judul,
            deskripsi: null,
            createdAt: now,
            updatedAt: now,
          ),
        );
        if (item.jadikanTarget) {
          final targetDate = item.tanggal ?? tanggal!;

          final existingTarget =
          await targetRepository.findDuplicate(
            childId: child.id!,
            nama: item.judul,
            kategori: item.kategori,
            targetDate: targetDate,
          );

          if (existingTarget != null) {
            continue;
          }

          final targetId = await targetRepository.add(
            Target(
              childId: child.id!,
              nama: item.judul,
              kategori: item.kategori,
              isCompleted: false,
              targetDate: targetDate,
              createdAt: now,
              updatedAt: now,
            ),
          );

          await dailyTargetRepository.add(
            DailyTarget(
              childId: child.id!,
              targetId: targetId,
              tanggal: targetDate,
              isCompleted: false,
              completedAt: null,
              createdAt: now,
            ),
          );
        }
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Gagal menyimpan jadwal: $e",
          ),
        ),
      );
    }
  }

  Future<void> editKategori(
      JadwalParserItem item,
      ) async {
    final hasil = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Pilih Kategori"),
          children: [
            ...kategoriList.map(
                  (kategori) {
                return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      kategori,
                    );
                  },
                  child: Text(kategori),
                );
              },
            ),
          ],
        );
      },
    );

    if (hasil == null) return;

    setState(() {
      item.kategori = hasil;
    });
  }

  Future<void> simpan() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return;
    }

    if (tanggal == null ||
        judulController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tanggal dan judul harus diisi.",
          ),
        ),
      );

      return;
    }

    setState(() {
      isSaving = true;
    });

    final now = DateTime.now();

    final jadwal = JadwalSekolah(
      childId: child.id!,
      tanggal: tanggal!,
      kategori: kategori,
      judul: judulController.text.trim(),
      deskripsi:
      deskripsiController.text.trim().isEmpty
          ? null
          : deskripsiController.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    await repository.add(jadwal);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Jadwal"),
        centerTitle: true,
      ),

      body: ListView(


        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Scan Jadwal dari Foto",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Foto jadwal dari TK dapat dibaca "
                        "otomatis oleh aplikasi.",
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isScanning
                              ? null
                              : () {
                            scanFoto(
                              ImageSource.camera,
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                          label: const Text("Kamera"),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isScanning
                              ? null
                              : () {
                            scanFoto(
                              ImageSource.gallery,
                            );
                          },
                          icon: const Icon(
                            Icons.photo_library_outlined,
                          ),
                          label: const Text("Galeri"),
                        ),
                      ),
                    ],
                  ),

                  if (isScanning) ...[
                    const SizedBox(height: 16),

                    const Center(
                      child: CircularProgressIndicator(),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        "Membaca jadwal...",
                      ),
                    ),
                  ],

                  if (hasilParser.isNotEmpty) ...[
                    const SizedBox(height: 16),

                    const Text(
                      "Materi yang Ditemukan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ...hasilParser.map(
                          (item) {
                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: ListTile(
                            dense: true,

                            leading: const Icon(
                              Icons.menu_book_outlined,
                            ),

                            title: Text(
                              item.judul,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    editKategori(item);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: Text(
                                    item.kategori,
                                  ),
                                ),

                                if (item.tanggal != null)
                                  Text(
                                    "${item.tanggal!.day}/"
                                        "${item.tanggal!.month}/"
                                        "${item.tanggal!.year}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),

                                CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  title: const Text(
                                    "Jadikan target rumah",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  value: item.jadikanTarget,
                                  onChanged: (value) {
                                    setState(() {
                                      item.jadikanTarget = value ?? false;
                                    });
                                  },
                                ),
                              ],
                            ),

                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 18,
                              ),
                              onPressed: () {
                                editMateri(item);
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isSaving
                            ? null
                            : simpanHasilScan,
                        icon: const Icon(
                          Icons.save_outlined,
                        ),
                        label: Text(
                          isSaving
                              ? "Menyimpan..."
                              : "Simpan Jadwal",
                        ),
                      ),
                    ),

                  ],

                  if (hasilScan != null) ...[
                    const SizedBox(height: 16),

                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text(
                        "Teks hasil OCR",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Text(
                            hasilScan!,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.calendar_today_outlined,
            ),
            title: const Text(
              "Tanggal",
            ),
            subtitle: Text(
              tanggal == null
                  ? "Pilih tanggal"
                  : "${tanggal!.day}/"
                  "${tanggal!.month}/"
                  "${tanggal!.year}",
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: pilihTanggal,
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: kategori,
            decoration: const InputDecoration(
              labelText: "Kategori",
              border: OutlineInputBorder(),
            ),
            items: [
              ...kategoriList.map(
                    (item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                },
              ),
              const DropdownMenuItem<String>(
                value: "__tambah_kategori__",
                child: Text(
                  "+ Tambah Kategori",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            onChanged: (value) async {
              if (value == null) return;

              if (value == "__tambah_kategori__") {
                await tambahKategori();
                return;
              }

              setState(() {
                kategori = value;
              });
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: judulController,
            decoration: const InputDecoration(
              labelText: "Judul / Materi",
              hintText: "Contoh: QS. Al-Falaq",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: deskripsiController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Deskripsi",
              hintText: "Catatan tambahan (opsional)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isSaving ? null : simpan,
              icon: const Icon(Icons.save_outlined),
              label: Text(
                isSaving
                    ? "Menyimpan..."
                    : "Simpan Jadwal",
              ),
            ),
          ),
        ],
      ),
    );
  }
}