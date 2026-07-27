import 'package:flutter/material.dart';

class HistoryCalendarScreen extends StatelessWidget {
  const HistoryCalendarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalender Belajar",
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Calendar Coming Soon",
        ),
      ),
    );
  }
}