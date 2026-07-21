import 'package:flutter/material.dart';
import 'hafalan_screen.dart';
import 'ibadah_screen.dart';
import 'target_screen.dart';
import 'profile_screen.dart';
import '../services/dashboard_service.dart';
import 'child_selector_screen.dart';
import '../services/current_child_service.dart';
import 'dart:io';
import '../models/guardian.dart';
import '../repositories/guardian_repository.dart';
import 'guardian_screen.dart';
import '../repositories/target_repository.dart';
import '../models/target.dart';
import '../services/learning_engine.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dashboardService = DashboardService();
  final guardianRepository = GuardianRepository();
  final targetRepository = TargetRepository();
  final learningEngine = LearningEngine();
  String learningMessage = "";
  LearningRecommendation? recommendation;

  Guardian? guardian;

  double progress = 0;
  int ibadahCount = 0;
  int hafalanCount = 0;

  int totalTargetHariIni = 0;
  int targetSelesaiHariIni = 0;

  String strength = "";
  String improvement = "";
  List<double> weeklyProgress = [];
  List<Target> todayTargets = [];

  @override
  void initState() {
    super.initState();

    loadGuardian();
    loadProgress();
    loadTargetSummary();
    loadTodayTargets();
  }

  Future<void> loadTargetSummary() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final summary = await targetRepository.getTodaySummary(
      child.id!,
    );

    if (!mounted) return;

    setState(() {
      totalTargetHariIni = summary["total"] ?? 0;
      targetSelesaiHariIni = summary["selesai"] ?? 0;
    });
  }

  Future<void> loadTodayTargets() async {
    final child = CurrentChildService.currentChild;

    if (child == null) return;

    final result = await learningEngine.getTodayTargets(
      child,
    );

    if (!mounted) return;

    setState(() {
      todayTargets = result;

      learningMessage =
          learningEngine.getGreetingMessage(result);

      recommendation =
          learningEngine.generateRecommendation(result);
    });
  }

  Future<void> loadProgress() async {
    final dashboard = await dashboardService.loadDashboard();

    if (!mounted) return;

    setState(() {
      progress = dashboard.progress;
      ibadahCount = dashboard.ibadahCount;
      hafalanCount = dashboard.hafalanCount;

      strength = dashboard.strength;
      improvement = dashboard.improvement;

      weeklyProgress = dashboard.weeklyProgress;
    });
  }

  Future<void> loadGuardian() async {
    final data = await guardianRepository.getGuardian();

    if (!mounted) return;

    setState(() {
      guardian = data;
    });
  }

  Future<void> pilihAnak() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChildSelectorScreen(),
      ),
    );

    if (result == true) {
      await loadProgress();
      await loadGuardian();
      await loadTargetSummary();
      await loadTodayTargets();

      if (!mounted) return;

      setState(() {});
    }

  }

  Widget buildWeeklyItem(
      String day,
      double value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(day),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
            ),
          ),

          const SizedBox(width: 10),

          Text("${(value * 100).toInt()}%"),
        ],
      ),
    );
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
                backgroundImage: guardian?.foto != null
                    ? FileImage(
                  File(guardian!.foto!),
                )
                    : null,
                child: guardian?.foto == null
                    ? Text(
                  guardian == null
                      ? "?"
                      : guardian!.namaPanggilan
                      .substring(0, 1)
                      .toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                )
                    : null,
              ),

              const SizedBox(width: 10,),
              Expanded(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guardian == null
                          ? "ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ"
                          : "ٱلسَّلَامُ عَلَيْكُمْ ${guardian!.jenisKelamin}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    Text(
                      guardian == null
                          ? "Ahlan Wa Sahlan"
                          : "Ahlan Wa Sahlan, \n"
                          "${guardian!.namaPanggilan}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10,),

          Text(
            guardian == null
                ? "Lengkapi data wali untuk mulai menggunakan aplikasi."
                : "Pantau perkembangan hafalan, ibadah, dan target harian anak.",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
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

                  leading: CircleAvatar(
                    backgroundImage: CurrentChildService.currentChild?.foto != null
                        ? FileImage(
                      File(CurrentChildService.currentChild!.foto!),
                    )
                        : null,
                    child: CurrentChildService.currentChild?.foto == null
                        ? const Icon(Icons.child_care)
                        : null,
                  ),

                  title: const Text("Nama"),

                  subtitle: Text(
                    CurrentChildService.currentChild?.namaLengkap ??
                        "Belum memilih anak",
                  ),
                ),

                const Divider(),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.workspace_premium),
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

                Row(
                  children: const [
                    Icon(
                      Icons.flag,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Rekomendasi Hari Ini",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  learningMessage,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                if (recommendation != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              recommendation!.icon,
                              color: recommendation!.color,
                              size: 28,
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              "Autopilot Learning Engine",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                recommendation!.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: recommendation!.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${recommendation!.estimatedMinutes} menit",
                                style: TextStyle(
                                  color: recommendation!.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Chip(
                          avatar: Icon(
                            recommendation!.icon,
                            color: recommendation!.color,
                            size: 18,
                          ),
                          label: Text(recommendation!.category),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          recommendation!.description,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "Mengapa direkomendasikan?",
                          style: TextStyle(
                            color: recommendation!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          recommendation!.reason,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Colors.green,
                              size: 18,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              "${recommendation!.estimatedMinutes} menit",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20,),

                if (todayTargets.isEmpty)
                  const Text(
                    "Belum ada target hari ini.",
                  )
                else
                  ...todayTargets.take(3).map(
                        (target) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            target.isCompleted
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: target.isCompleted
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  target.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  target.kategori,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (todayTargets.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TargetScreen(),
                          ),
                        );

                        if (result == true) {
                          await loadTargetSummary();
                          await loadTodayTargets();

                          if (!mounted) return;

                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      label: Text(
                        "Lihat ${todayTargets.length - 3} target lainnya",
                      ),
                    ),
                  ),

                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Progress Hari Ini",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$targetSelesaiHariIni/$totalTargetHariIni",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: totalTargetHariIni == 0
                      ? 0
                      : targetSelesaiHariIni / totalTargetHariIni,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                ),

                const SizedBox(height: 8,),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    totalTargetHariIni == 0
                        ? "Belum dimulai"
                        : "${((targetSelesaiHariIni / totalTargetHariIni) * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
          ),

          const SizedBox(height: 20,),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ringkasan Hari Ini",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                    const SizedBox(height: 20,),

                  Text(
                    "Ringkasan aktivitas belajar hari ini.",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryItem(
                          Icons.flag,
                          "Target",
                          "$targetSelesaiHariIni/$totalTargetHariIni",
                          Colors.green,
                        ),

                        const SizedBox(width: 12),

                        _buildSummaryItem(
                          Icons.menu_book,
                          "Hafalan",
                          hafalanCount.toString(),
                          Colors.blue,
                        ),

                        const SizedBox(width: 12),

                        _buildSummaryItem(
                          Icons.mosque,
                          "Ibadah",
                          ibadahCount.toString(),
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
                    children: [buildWeeklyItem(
                      "Sen",
                      weeklyProgress.isNotEmpty
                          ? weeklyProgress[0]
                          : 0,
                    ),

                      buildWeeklyItem(
                        "Sel",
                        weeklyProgress.length > 1
                            ? weeklyProgress[1]
                            : 0,
                      ),

                      buildWeeklyItem(
                        "Rab",
                        weeklyProgress.length > 2
                            ? weeklyProgress[2]
                            : 0,
                      ),

                      buildWeeklyItem(
                        "Kam",
                        weeklyProgress.length > 3
                            ? weeklyProgress[3]
                            : 0,
                      ),

                      buildWeeklyItem(
                        "Jum",
                        weeklyProgress.length > 4
                            ? weeklyProgress[4]
                            : 0,
                      ),

                      buildWeeklyItem(
                        "Sab",
                        weeklyProgress.length > 5
                            ? weeklyProgress[5]
                            : 0,
                      ),

                      buildWeeklyItem(
                        "Min",
                        weeklyProgress.length > 6
                            ? weeklyProgress[6]
                            : 0,
                      ),
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

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(strength),
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
                        color: Colors.orange,
                        size: 8,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(improvement),
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Target Harian",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Kelola target belajar untuk Autopilot Learning Engine.",
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TargetScreen(),
                          ),
                        );

                        if (result == true) {
                          await loadTargetSummary();
                          await loadTodayTargets();

                          if (!mounted) return;

                          setState(() {});
                        }
                      },
                      child: const Text("Buka"),
                    ),
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
                  "Profil Anak",
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Profil Wali",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    guardian == null
                        ? "Silakan lengkapi data wali terlebih dahulu."
                        : guardian!.namaLengkap,
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GuardianScreen(),
                          ),
                        );

                        if (result == true) {
                          await loadGuardian();
                          await loadProgress();

                          if (!mounted) return;

                          setState(() {});
                        }
                      },
                      child: Text(
                        guardian == null
                            ? "Tambah Data Wali"
                            : "Edit Data Wali",
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    guardian == null
                        ? "-"
                        : guardian!.jenisKelamin,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IbadahScreen(),
                      ),
                    );
                  },
                ),

                const Divider(height: 1,),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profil anak"),
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
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
