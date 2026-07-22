import 'package:flutter/material.dart';

class QuickMenuCard extends StatelessWidget {
  final VoidCallback onHafalan;
  final VoidCallback onIbadah;
  final VoidCallback onProfile;

  const QuickMenuCard({
    super.key,
    required this.onHafalan,
    required this.onIbadah,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text("Hafalan"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onHafalan,
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.mosque),
            title: const Text("Ibadah"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onIbadah,
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil Anak"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onProfile,
          ),
        ],
      ),
    );
  }
}