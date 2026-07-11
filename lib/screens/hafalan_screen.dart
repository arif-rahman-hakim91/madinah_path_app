import 'package:flutter/material.dart';
import 'add_hafalan_screen.dart';

class HafalanScreen extends StatelessWidget {
  const HafalanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hafalan"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
            MaterialPageRoute(
              builder: (context) => const AddHafalanScreen(),
            ),
            );
          },
      child: const Icon(Icons.add),
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
                  "Hafalan Hari Ini",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const ListTile(
                    leading: Icon(
                      Icons.menu_book,
                      color: Colors.green,
                    ),
                    title: Text("Surat Al-Ratihah"),
                    subtitle: Text("Ayat : 1 - 7"),
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
