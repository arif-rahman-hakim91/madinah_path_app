import 'package:flutter/material.dart';

import '../models/child.dart';
import '../repositories/child_repository.dart';
import '../services/current_child_service.dart';
import 'add_child_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddChildScreen(),
                ),
              );

              await loadChildren();
            },
          ),
        ],
      ),
      body: children.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.woman,
              size: 70,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),

            const Text(
              "Belum ada data anak.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Silakan tambahkan anak terlebih dahulu.",
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () async {

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddChildScreen(),
                  ),
                );

                if (result == true) {
                  await loadChildren();
                }

                await loadChildren();
              },

              icon: const Icon(Icons.add),

              label: const Text("Tambah Anak"),
            ),
          ],
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

              if (!mounted) return;

              Navigator.pop(context, true);
            },
          );
        },
      ),
    );
  }
}