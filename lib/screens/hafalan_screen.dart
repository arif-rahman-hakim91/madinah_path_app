import 'package:flutter/material.dart';
import 'add_hafalan_screen.dart';
import '../data/hafalan_data.dart';

class HafalanScreen extends StatefulWidget {
  const HafalanScreen({super.key});

  @override
  State<HafalanScreen> createState() => _HafalanScreenState();
}

class _HafalanScreenState extends State<HafalanScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hafalan"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddHafalanScreen(),
              ),
            );

            setState(() {});
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

                  if (daftarHafalan.isEmpty)

                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Belum ada hafalan.\nTekan tombol + untuk menambahkan hafalan.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )

                  else

                    ...daftarHafalan.map(
                          (hafalan) => ListTile(
                            leading: const Icon(
                              Icons.menu_book,
                              color: Colors.green,
                            ),

                            title: Text(hafalan.namaSurat),

                            subtitle: Text(
                              "Ayat : ${hafalan.ayat}",
                            ),

                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {

                                setState(() {
                                  daftarHafalan.remove(hafalan);
                                });

                              },
                            ),
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
