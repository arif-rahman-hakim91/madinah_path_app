import 'package:flutter/material.dart';

import '../models/child.dart';
import '../repositories/child_repository.dart';
import 'add_child_screen.dart';
import 'edit_child_screen.dart';

class ChildScreen extends StatefulWidget {
  const ChildScreen({super.key});

  @override
  State<ChildScreen> createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
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

  Future<void> deleteChild(Child child) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hapus Anak"),
          content: Text(
            "Yakin ingin menghapus ${child.namaLengkap}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await repository.delete(child.id!);

    await loadChildren();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Data anak berhasil dihapus.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Anak"),
        centerTitle: true,
      ),
      body: children.isEmpty
          ? const Center(
        child: Text(
          "Belum ada data anak.",
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.child_care),
              ),
              title: Text(child.namaLengkap),
              subtitle: Text(child.namaPanggilan),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit") {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditChildScreen(
                          child: child,
                        ),
                      ),
                    );

                    if (result == true) {
                      await loadChildren();
                    }
                  }

                  if (value == "delete") {
                    await deleteChild(child);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: "edit",
                    child: Text("Edit"),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text("Hapus"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}