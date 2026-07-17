import 'package:flutter/material.dart';

import '../models/child.dart';
import '../repositories/child_repository.dart';
import '../services/current_child_service.dart';

class ChildSelectorScreen extends StatefulWidget {
  const ChildSelectorScreen({super.key});

  @override
  State<ChildSelectorScreen> createState() => _ChildSelectorScreenState();
}

class _ChildSelectorScreenState extends State<ChildSelectorScreen> {
  final repository = ChildRepository();

  List<Child> children = [];

  @override
  void initState() {
    super.initState();
    loadChildren();
  }

  Future<void> loadChildren() async {
    final data = await repository.getAll();

    if (!mounted) return;

    setState(() {
      children = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Anak"),
        centerTitle: true,
      ),
      body: children.isEmpty
          ? const Center(
        child: Text(
          "Belum ada data anak.",
        ),
      )
          : ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];

          final isSelected =
              CurrentChildService.currentChild?.id == child.id;

          return ListTile(
            leading: CircleAvatar(
              child: Text(
                child.namaPanggilan[0].toUpperCase(),
              ),
            ),
            title: Text(child.namaLengkap),
            subtitle: Text(child.namaPanggilan),
            trailing: isSelected
                ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
                : null,
            onTap: () {
              CurrentChildService.setCurrentChild(child);

              Navigator.pop(context, true);
            },
          );
        },
      ),
    );
  }
}