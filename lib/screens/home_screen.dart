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
         
          Row(
            children: [
              const Icon(
                Icons.wb_sunny_outlined,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 10,),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  Text("Ahlan Wa Sahlan",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ],
          ),

          const SizedBox(height: 10,),

          const Text("Pantau perkembangan belajar dan ibadah anak setiap hari",
          style: TextStyle(fontSize: 15,
          color: Colors.grey),
          ),

          const SizedBox(height: 30,),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
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

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.badge,
                    color: Colors.green,
                  ),
                  title: Text("Nama"),
                  subtitle: Text("Hanifah Sholihah"),
                ),

                const Divider(),

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.school,
                    color: Colors.blue,
                  ),
                  title: Text("Kelas"),
                  subtitle: Text("TKA"),
                ),
                
                const Divider(),
                
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.orange,
                  ),
                  title: Text("Sekolah"),
                  subtitle: Text("RA Al Misykaah Pekanbaru"),
                )
            ],
            ),

            ),
          ),
          
          const SizedBox(height: 20,),
          
          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const Row(
                  children: [
                    Icon(
                      Icons.flag,
                      color: Colors.deepOrange,
                    ),
                    
                    SizedBox(width: 10,),
                    
                    Text("Target Hari Ini",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20,),
                
                const Text("Menghafal Surat Al-Fatihah"),
                
                const SizedBox(height: 10,),
                
                LinearProgressIndicator(
                  value: 0.4,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                ),
                
                const SizedBox(height: 8,),
                
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("40%"),
                )
              ],
            ),),
          )
        ],
      )
    );
  }
}
