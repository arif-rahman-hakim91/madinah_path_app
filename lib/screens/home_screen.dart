import 'package:flutter/material.dart';
import 'hafalan_screen.dart';
import 'ibadah_screen.dart';
import 'target_screen.dart';
import 'profile_screen.dart';
import '../services/dashboard_service.dart';
import 'child_selector_screen.dart';
import '../services/current_child_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dashboardService = DashboardService();

  double progress = 0;
  int ibadahCount = 0;
  int hafalanCount = 0;

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final value = await dashboardService.getTodayProgress();
    final ibadah = await dashboardService.getTodayIbadahCount();
    final hafalan = await dashboardService.getTodayHafalanCount();

    if (!mounted) return;

    setState(() {
      progress = value;
      ibadahCount = ibadah;
      hafalanCount = hafalan;
    });
  }
  Future<void> pilihAnak() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChildSelectorScreen(),
      ),
    );

    if (result == true && mounted) {
      setState(() {});
    }
  }

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

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green.shade100,
                child: const Icon(
                  Icons.person,
                  color: Colors.green,
                  size: 30,
                ),
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
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.child_care,
                      size: 40,
                      color: Colors.green,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Anak Aktif",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person),
                  title: const Text("Nama"),
                  subtitle: Text(
                    CurrentChildService.currentChild?.namaLengkap ??
                        "Belum memilih anak",
                  ),
                ),

                const Divider(),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cake),
                  title: const Text("Nama Panggilan"),
                  subtitle: Text(
                    CurrentChildService.currentChild?.namaPanggilan ??
                        "-",
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: pilihAnak,
                    child: const Text("Ganti Anak"),
                  ),
                ),
              ],
            )

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
                  value: progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                ),
                
                const SizedBox(height: 8,),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${(progress * 100).toStringAsFixed(0)}%",
                  ),
                ),
              ],
            ),),
          ),

          const SizedBox(height: 20,),

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Ringkasan Hari Ini",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          Icons.menu_book,
                          "Hafalan",
                          "$hafalanCount",
                          Colors.green,),
                        _buildSummaryItem(
                          Icons.mosque,
                          "Ibadah",
                            "$ibadahCount",
                          Colors.blue
                        ),
                        _buildSummaryItem(
                          Icons.star,
                          "Progress",
                          "${(progress * 100).toStringAsFixed(0)}%",
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Konsistensi Mingguan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),

                  const SizedBox(height: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text("Senin"),
                      
                      const SizedBox(height: 6,),
                      
                      LinearProgressIndicator(
                        value: 0.9,
                        minHeight: 8,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 15,),
                      
                      const Text("Selasa"),
                      
                      const SizedBox(height: 6,),
                      
                      LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 8,
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                      const SizedBox(height: 15,),
                      
                      const Text("Rabu"),
                      
                      const SizedBox(height: 6,),
                      
                      LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 8,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Kelebihan & Perlu Ditingkatkan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    children: [

                      const Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                      ),

                      const SizedBox(width: 10,),

                      const Text(
                        "Kelebihan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 15,),

                  Row(
                    children: [

                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),

                      const SizedBox(height: 10,),
                      const SizedBox(width: 8,),

                      const Text(
                        "Hafalan meningkat setiap hari",
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [

                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),

                      const SizedBox(width: 8,),

                      const Text(
                        "Rajin shalat 5 waktu"
                      ),
                    ],
                  ),

                  const SizedBox(height: 25,),

                  Row(
                    children: [

                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 10,),

                      const Text(
                        "Perlu Ditingkatkan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15,),

                  Row(
                    children: [

                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 10,),

                      const Expanded(
                          child: Text(
                              "Muraja'ah lebih rutin"
                          ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [

                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 10,),

                      const Expanded(
                          child: Text(
                              "Bangun lebih awal untuk shalat Subuh agar aktifitas harian jadi lebih mudah.",
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HafalanScreen(),
              ),
              );
            },
              icon: const Icon(Icons.menu_book),
              label: const Text("Buka Halaman Hafalan"),),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Ibadah Hari Ini",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    "Yuk isi checklist ibadah hari ini"
                  ),

                  const SizedBox(height: 15,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const IbadahScreen(),),);
                    },
                    child: const Text("Buka"),),
                  ),
                ],
              ),),
          ),
          Card(
            child: Padding(padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Target Harian",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    "Kelola target belajar dan ibadah harian."
                  ),

                  const SizedBox(height: 15,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TargetScreen(),
                        ),
                      );
                    }, child: const Text("Buka")),
                  ),
                ],
              ),
            ),
          ),

          Card(
            child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Profil",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 10,),

                const Text(
                    "Lihat informasi anak dan pengeturan aplikasi"),

                const SizedBox(height: 15,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),
                      ),
                    );
                  }, child: const Text("Buka")),
                )
              ],
            ),),
          ),
          Card(
            child: Column(
              children: [

                ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: const Text("Hafalan"),
                  trailing: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HafalanScreen(),
                      ),
                    );
                  },
                ),

                const Divider(height: 1,),

                ListTile(
                  leading: const Icon(Icons.mosque),
                  title: const Text("Ibadah"),
                  trailing: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TargetScreen(),
                      ),
                    );
                  },
                ),

                const Divider(height: 1,),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profil"),
                  trailing: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
Widget _buildSummaryItem(
    IconData icon,
    String title,
    String value,
    Color color,
    ) {
    return Column(
      children: [
        Icon(icon,
        color: color,
        size: 32,
        ),

        const SizedBox(height: 8,),

        Text(value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
        ),

        Text(title)

      ],
    );
}
}
