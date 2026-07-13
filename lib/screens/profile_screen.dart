import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                const CircleAvatar(
                  radius: 45,
                  child: Icon(
                    Icons.person,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 15,),

                const Text("Nama Anak",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5,),

                const Text("Tingkat TK-A"),

                const SizedBox(height: 20,),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text("Progress Hafalan"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text("Pencapaian"),
                  trailing: const Icon(Icons.arrow_back_ios),
                  onTap: () {},
                )
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
