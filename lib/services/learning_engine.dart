import '../models/child.dart';
import '../models/target.dart';
import '../repositories/target_repository.dart';
import 'package:flutter/material.dart';

class LearningRecommendation {
  final String title;
  final String description;
  final String category;
  final int estimatedMinutes;
  final String reason;
  final IconData icon;
  final Color color;

  const LearningRecommendation({
    required this.title,
    required this.description,
    required this.category,
    required this.reason,
    required this.estimatedMinutes,
    required this.icon,
    required this.color,

  });
}

class LearningEngine {
  final TargetRepository targetRepository = TargetRepository();

  static const Map<String, int> priority = {
    // =========================
    // AL-QUR'AN
    // =========================
    "Murajaah": 1,
    "Hafalan": 2,
    "Mutqin": 3,
    "Tilawah": 4,

    // =========================
    // IBADAH
    // =========================
    "Shalat": 5,
    "Dzikir": 6,
    "Doa": 7,
    "Wudhu": 8,

    // =========================
    // ILMU ISLAM
    // =========================
    "Hadits": 9,
    "Aqidah": 10,
    "Fiqih": 11,
    "Sirah": 12,
    "Asmaul Husna": 13,

    // =========================
    // ADAB
    // =========================
    "Adab": 14,
    "Akhlak": 15,

    // =========================
    // BAHASA
    // =========================
    "Huruf Hijaiyah": 16,
    "Iqra": 17,
    "Bahasa Arab": 18,
    "Huruf Latin": 19,
    "Membaca": 20,

    // =========================
    // KOGNITIF
    // =========================
    "Berhitung": 21,
    "Warna": 22,
    "Bentuk": 23,
    "Pola": 24,

    // =========================
    // MOTORIK
    // =========================
    "Motorik Halus": 25,
    "Motorik Kasar": 26,

    // =========================
    // LIFE SKILL
    // =========================
    "Kemandirian": 27,
    "Life Skill": 28,
    "Proyek Amal": 29,
  };

  Future<List<Target>> getTodayTargets(
      Child child,
      ) async {
    final targets = await targetRepository.getPendingToday(
      child.id!,
    );

    targets.sort(
          (a, b) {
        final aPriority = priority[a.kategori] ?? 999;
        final bPriority = priority[b.kategori] ?? 999;

        return aPriority.compareTo(bPriority);
      },
    );

    return targets;
  }

  List<Target> getQuranTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Murajaah" ||
          target.kategori == "Hafalan" ||
          target.kategori == "Mutqin" ||
          target.kategori == "Tilawah";
    }).toList();
  }

  List<Target> getIbadahTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Shalat" ||
          target.kategori == "Dzikir" ||
          target.kategori == "Doa" ||
          target.kategori == "Wudhu";
    }).toList();
  }

  List<Target> getIslamicKnowledgeTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Hadits" ||
          target.kategori == "Aqidah" ||
          target.kategori == "Fiqih" ||
          target.kategori == "Sirah" ||
          target.kategori == "Asmaul Husna";
    }).toList();
  }

  List<Target> getLanguageTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Huruf Hijaiyah" ||
          target.kategori == "Iqra" ||
          target.kategori == "Bahasa Arab" ||
          target.kategori == "Huruf Latin" ||
          target.kategori == "Membaca";
    }).toList();
  }

  List<Target> getCognitiveTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Berhitung" ||
          target.kategori == "Warna" ||
          target.kategori == "Bentuk" ||
          target.kategori == "Pola";
    }).toList();
  }

  List<Target> getMotoricTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Motorik Halus" ||
          target.kategori == "Motorik Kasar";
    }).toList();
  }

  List<Target> getLifeSkillTargets(
      List<Target> targets,
      ) {
    return targets.where((target) {
      return target.kategori == "Kemandirian" ||
          target.kategori == "Life Skill" ||
          target.kategori == "Proyek Amal";
    }).toList();
  }

  Map<String, List<Target>> groupTargets(
      List<Target> targets,
      ) {
    return {
      "Al-Qur'an": getQuranTargets(targets),
      "Ibadah": getIbadahTargets(targets),
      "Ilmu Islam": getIslamicKnowledgeTargets(targets),
      "Bahasa": getLanguageTargets(targets),
      "Kognitif": getCognitiveTargets(targets),
      "Motorik": getMotoricTargets(targets),
      "Life Skill": getLifeSkillTargets(targets),
    };
  }

  List<String> getRecommendedBlocks(
      List<Target> targets,
      ) {
    final groups = groupTargets(targets);

    final result = <String>[];

    groups.forEach((key, value) {
      if (value.isNotEmpty) {
        result.add(key);
      }
    });

    return result;
  }

  String getGreetingMessage(
      List<Target> targets,
      ) {
    if (targets.isEmpty) {
      return "Hari ini belum ada rekomendasi belajar.";
    }

    final blocks = getRecommendedBlocks(targets);

    return "Hari ini fokus pada ${blocks.join(", ")}.";
  }

  LearningRecommendation generateRecommendation(
      List<Target> targets,
      ) {
    if (targets.isEmpty) {
      return const LearningRecommendation(
        title: "Belum Ada Target",
        description: "Tambahkan target belajar terlebih dahulu.",
        category: "-",
        reason: "Belum ada target yang dapat direkomendasikan.",
        estimatedMinutes: 0,
        icon: Icons.info,
        color: Colors.grey,
      );
    }

    final target = targets.first;

    String description = "Fokus utama belajar hari ini.";
    String reason = "Learning Engine memilih target dengan prioritas tertinggi.";
    int estimatedMinutes = 15;

    IconData icon = Icons.school;
    Color color = Colors.blue;

    switch (target.kategori) {
      case "Murajaah":
        description =
        "Sudah waktunya mengulang hafalan agar tetap kuat.";
        reason =
        "Murajaah memiliki prioritas tertinggi pada Learning Engine.";
        estimatedMinutes = 15;
        icon = Icons.menu_book;
        color = Colors.green;
        break;

      case "Hafalan":
        description =
        "Hari ini saat yang baik untuk menambah hafalan baru.";
        reason =
        "Murajaah hari ini sudah aman sehingga dapat melanjutkan hafalan.";
        estimatedMinutes = 20;
        icon = Icons.menu_book;
        color = Colors.green;
        break;

      case "Mutqin":
        description =
        "Perkuat hafalan hingga benar-benar mutqin.";
        reason =
        "Target ini dipilih untuk memperkuat hafalan yang hampir mutqin.";
        estimatedMinutes = 20;
        icon = Icons.verified;
        color = Colors.green;
        break;

      case "Tilawah":
        description =
        "Tilawah untuk menjaga kelancaran bacaan.";
        reason =
        "Tilawah dipilih agar bacaan Al-Qur'an tetap lancar dan terjaga.";
        estimatedMinutes = 15;
        icon = Icons.auto_stories;
        color = Colors.green;
        break;

      case "Shalat":
        description =
        "Jaga shalat tepat waktu dengan penuh kekhusyukan.";
        reason =
        "Shalat merupakan ibadah harian yang menjadi prioritas utama.";
        estimatedMinutes = 10;
        icon = Icons.mosque;
        color = Colors.teal;
        break;

      case "Dzikir":
        description =
        "Luangkan waktu untuk dzikir pagi atau petang.";
        reason =
        "Dzikir membantu membiasakan anak mengingat Allah dalam kehidupan sehari-hari.";
        estimatedMinutes = 10;
        icon = Icons.favorite;
        color = Colors.red;
        break;

      case "Doa":
        description =
        "Pelajari dan amalkan doa harian.";
        reason =
        "Doa harian dipilih agar menjadi kebiasaan dalam setiap aktivitas.";
        estimatedMinutes = 10;
        icon = Icons.volunteer_activism;
        color = Colors.orange;
        break;

      case "Hadits":
        description =
        "Pelajari satu hadits pendek beserta maknanya.";
        reason =
        "Hadits dipilih untuk mengenalkan sunnah Rasulullah ﷺ sesuai usia anak.";
        estimatedMinutes = 15;
        icon = Icons.library_books;
        color = Colors.indigo;
        break;

      case "Bahasa Arab":
        description =
        "Tambahkan kosakata Bahasa Arab hari ini.";
        reason =
        "Bahasa Arab membantu anak memahami Al-Qur'an dan ilmu syar'i secara bertahap.";
        estimatedMinutes = 15;
        icon = Icons.translate;
        color = Colors.deepPurple;
        break;

      case "Berhitung":
        description =
        "Latih kemampuan berhitung sesuai usia anak.";
        reason =
        "Berhitung dipilih untuk mengembangkan kemampuan logika dan numerasi anak.";
        estimatedMinutes = 15;
        icon = Icons.calculate;
        color = Colors.blue;
        break;

      case "Motorik Kasar":
        description =
        "Lakukan aktivitas fisik yang sesuai usia anak.";
        reason =
        "Motorik kasar penting untuk melatih keseimbangan, koordinasi, dan kekuatan tubuh anak.";
        estimatedMinutes = 20;
        icon = Icons.directions_run;
        color = Colors.deepOrange;
        break;

      default:
        description =
        "Fokus utama belajar hari ini.";
        reason =
        "Learning Engine memilih target dengan prioritas tertinggi.";
        estimatedMinutes = 15;
        icon = Icons.school;
        color = Colors.blue;
    }

    return LearningRecommendation(
      title: target.nama,
      description: description,
      category: target.kategori,
      reason: reason,
      estimatedMinutes: estimatedMinutes,
      icon: icon,
      color: color,
    );
  }



}

