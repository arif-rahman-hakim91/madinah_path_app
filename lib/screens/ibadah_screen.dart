import 'package:flutter/material.dart';

import '../core/constants/app_message.dart';
import '../models/ibadah.dart';
import '../repositories/ibadah_repository.dart';
import 'ibadah_history_screen.dart';

class IbadahScreen extends StatefulWidget {
  final Ibadah? ibadah;

  const IbadahScreen({
    super.key,
    this.ibadah,
  });

  @override
  State<IbadahScreen> createState() => _IbadahScreenState();
}

class _IbadahScreenState extends State<IbadahScreen> {
  bool subuh = false;
  bool dzuhur = false;
  bool ashar = false;
  bool maghrib = false;
  bool isya = false;
  bool tilawah = false;
  bool dzikir = false;

  final repository = IbadahRepository();

  Ibadah? todayIbadah;

  @override
  void initState() {
    super.initState();

    if (widget.ibadah != null) {
      todayIbadah = widget.ibadah;

      subuh = widget.ibadah!.subuh;
      dzuhur = widget.ibadah!.dzuhur;
      ashar = widget.ibadah!.ashar;
      maghrib = widget.ibadah!.maghrib;
      isya = widget.ibadah!.isya;
      tilawah = widget.ibadah!.tilawah;
      dzikir = widget.ibadah!.dzikir;
    } else {
      loadToday();
    }
  }

  Future<void> loadToday() async {
    final data = await repository.getToday();

    if (!mounted) return;

    setState(() {
      if (data == null) {
        todayIbadah = null;

        subuh = false;
        dzuhur = false;
        ashar = false;
        maghrib = false;
        isya = false;
        tilawah = false;
        dzikir = false;
      } else {
        todayIbadah = data;

        subuh = data.subuh;
        dzuhur = data.dzuhur;
        ashar = data.ashar;
        maghrib = data.maghrib;
        isya = data.isya;
        tilawah = data.tilawah;
        dzikir = data.dzikir;
      }
    });
  }

  Future<void> saveToday() async {
    if (todayIbadah == null) {
      await repository.add(
        Ibadah(
          tanggal: DateTime.now(),
          subuh: subuh,
          dzuhur: dzuhur,
          ashar: ashar,
          maghrib: maghrib,
          isya: isya,
          tilawah: tilawah,
          dzikir: dzikir,
        ),
      );
    } else {
      await repository.update(
        Ibadah(
          id: todayIbadah!.id,
          tanggal: todayIbadah!.tanggal,
          subuh: subuh,
          dzuhur: dzuhur,
          ashar: ashar,
          maghrib: maghrib,
          isya: isya,
          tilawah: tilawah,
          dzikir: dzikir,
        ),
      );
    }

    await loadToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ibadah"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: "Riwayat",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const IbadahHistoryScreen(),
                ),
              );
            },
          ),
        ],
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
                  const Text(
                    "Ibadah Hari Ini",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  CheckboxListTile(
                    value: subuh,
                    onChanged: (value) {
                      setState(() => subuh = value ?? false);
                    },
                    title: const Text("Shalat Subuh"),
                  ),

                  CheckboxListTile(
                    value: dzuhur,
                    onChanged: (value) {
                      setState(() => dzuhur = value ?? false);
                    },
                    title: const Text("Shalat Dzuhur"),
                  ),

                  CheckboxListTile(
                    value: ashar,
                    onChanged: (value) {
                      setState(() => ashar = value ?? false);
                    },
                    title: const Text("Shalat Ashar"),
                  ),

                  CheckboxListTile(
                    value: maghrib,
                    onChanged: (value) {
                      setState(() => maghrib = value ?? false);
                    },
                    title: const Text("Shalat Maghrib"),
                  ),

                  CheckboxListTile(
                    value: isya,
                    onChanged: (value) {
                      setState(() => isya = value ?? false);
                    },
                    title: const Text("Shalat Isya"),
                  ),

                  CheckboxListTile(
                    value: tilawah,
                    onChanged: (value) {
                      setState(() => tilawah = value ?? false);
                    },
                    title: const Text("Tilawah"),
                  ),

                  CheckboxListTile(
                    value: dzikir,
                    onChanged: (value) {
                      setState(() => dzikir = value ?? false);
                    },
                    title: const Text("Dzikir Pagi & Petang"),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await saveToday();

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              AppMessage.saveSuccess,
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text("Simpan"),
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