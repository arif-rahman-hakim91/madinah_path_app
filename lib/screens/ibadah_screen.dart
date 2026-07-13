import 'package:flutter/material.dart';

class IbadahScreen extends StatelessWidget {
  const IbadahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ibadah"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Ibadah Hari Ini",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 20,),

                CheckboxListTile(
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Shalat Subuh"
                  ),
                ),
                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Shalat Dzuhur"
                  ),
                ),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Shalat Ashar"
                  ),
                ),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Shalat Maghrib"
                  ),
                ),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Shalat Isya"
                  ),
                ),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Tilawah"
                  ),
                ),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Dzikir Pagi & Petang"
                  ),
                ),

                const SizedBox(height: 20,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Simpan"
                    ),
                  ),
                ),
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
