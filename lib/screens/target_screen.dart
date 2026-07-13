import 'package:flutter/material.dart';

class TargetScreen extends StatelessWidget {
  const TargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target Harian"),
        centerTitle: true,
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
                  "Target Hari Ini",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 20,),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Hafalan 2 Baris"),),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Murajaah"),),

                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Membaca Al-Quran"),),
                
                CheckboxListTile(value: false, onChanged: (value) {},
                title: const Text("Hadist Harian"),),

                const SizedBox(height: 20,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("Simpan"),
                ),),
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
