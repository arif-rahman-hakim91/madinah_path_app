import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Madinah Path"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          
          const Text("Selamat datang di Madinah Path",
          style: TextStyle(
              fontSize: 18,color: Colors.grey),),
          const SizedBox(height: 25,),
          
          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green,
                    ),
                    SizedBox(width: 12),

                    Text("Profil Anak",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                
                Text("Nama      : Hanifah Sholihah"),
                
                SizedBox(height: 8,),
                
                Text("Kelas       : TKA"),
                
                SizedBox(height: 8,),
                
                Text("Sekolah   : RA Al Misyikaah Pekanbaru")
            ],
            ),

            ),
          )
        ],
      )
    );
  }
}
