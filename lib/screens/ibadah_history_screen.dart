import 'package:flutter/material.dart';

class IbadahHistoryScreen extends StatelessWidget {
  const IbadahHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Ibadah"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Belum ada data.",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}