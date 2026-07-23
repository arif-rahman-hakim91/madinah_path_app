import '../models/child.dart';
import '../models/target.dart';
import '../repositories/target_repository.dart';
import 'package:flutter/material.dart';
import 'priority_engine.dart';
import 'status_priority.dart';

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


  Future<List<Target>> getTodayTargets(
      Child child,
      ) async {
    final targets = await targetRepository.getByDate(
      childId: child.id!,
      date: DateTime.now(),
    );

    targets.sort(
          (a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }

        final aPriority =
            PriorityEngine.priority[a.kategori] ?? 999;

        final bPriority =
            PriorityEngine.priority[b.kategori] ?? 999;

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

    final sortedTargets = [...targets];

    sortedTargets.sort((a, b) {
      final aPriority =
          PriorityEngine.priority[a.kategori] ?? 999;

      final bPriority =
          PriorityEngine.priority[b.kategori] ?? 999;

      if (aPriority != bPriority) {
        return aPriority.compareTo(bPriority);
      }


      final aStatus =
          StatusPriority.priority[a.status] ?? 999;

      final bStatus =
          StatusPriority.priority[b.status] ?? 999;

      return aStatus.compareTo(bStatus);
    });

    final target = sortedTargets.first;


    String description = "Fokus utama belajar hari ini.";
    String reason = "Learning Engine memilih target dengan prioritas tertinggi.";
    int estimatedMinutes = 15;

    IconData icon = Icons.school;
    Color color = Colors.blue;

    switch (target.kategori) {
      case "Murajaah":

        if (target.status == "Belum Lancar") {
          description =
          "Murajaah perlu diulang karena belum lancar.";
          reason =
          "Engine mendeteksi hafalan belum lancar.";
          estimatedMinutes = 20;
        } else if (target.status == "Mutqin") {
          description =
          "Cukup lakukan murajaah ringan.";
          reason =
          "Hafalan sudah mutqin.";
          estimatedMinutes = 5;
        } else {
          description =
          "Sudah waktunya mengulang hafalan agar tetap kuat.";
          reason =
          "Murajaah memiliki prioritas tertinggi.";
          estimatedMinutes = 15;
        }

        icon = Icons.menu_book;
        color = Colors.green;
        break;

      case "Hafalan":

        if (target.status == "Belum Dipelajari") {
          description =
          "Hari ini mulai hafalan baru secara bertahap.";
          reason =
          "Materi belum pernah dipelajari.";
          estimatedMinutes = 20;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi hafalan hingga lebih lancar.";
          reason =
          "Engine mendeteksi hafalan belum lancar.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Perkuat hafalan agar semakin mantap.";
          reason =
          "Hafalan sudah berkembang dan perlu diperkuat.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Pertahankan hafalan dengan pengulangan ringan.";
          reason =
          "Hafalan sudah lancar.";
          estimatedMinutes = 10;
        } else {
          description =
          "Hafalan sudah mutqin, lanjut ke hafalan berikutnya.";
          reason =
          "Engine siap merekomendasikan materi baru.";
          estimatedMinutes = 5;
        }

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

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai membiasakan membaca Al-Qur'an secara bertahap.";
          reason =
          "Tilawah belum pernah dipelajari.";
          estimatedMinutes = 15;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi bacaan hingga lebih lancar dan benar.";
          reason =
          "Engine mendeteksi bacaan masih perlu diperbaiki.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Lanjutkan tilawah untuk meningkatkan kelancaran.";
          reason =
          "Kemampuan membaca sudah berkembang dan perlu ditingkatkan.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Jaga kelancaran dengan tilawah rutin setiap hari.";
          reason =
          "Tilawah sudah lancar dan perlu dijaga konsistensinya.";
          estimatedMinutes = 10;
        } else {
          description =
          "Tilawah sudah sangat baik, lanjutkan sebagai murajaah rutin.";
          reason =
          "Kemampuan membaca sudah stabil.";
          estimatedMinutes = 5;
        }

        icon = Icons.auto_stories;
        color = Colors.green;
        break;

      case "Shalat":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai mengenalkan tata cara shalat sesuai kemampuan anak.";
          reason =
          "Anak baru mulai mempelajari shalat.";
          estimatedMinutes = 15;
        } else if (target.status == "Belum Lancar") {
          description =
          "Latih kembali gerakan dan bacaan shalat secara bertahap.";
          reason =
          "Engine mendeteksi latihan shalat masih perlu pengulangan.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Lanjutkan latihan agar gerakan dan bacaan semakin baik.";
          reason =
          "Kemampuan shalat sudah berkembang namun masih perlu penguatan.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Pertahankan kebiasaan shalat tepat waktu.";
          reason =
          "Shalat sudah berjalan dengan baik dan perlu dijaga konsistensinya.";
          estimatedMinutes = 10;
        } else {
          description =
          "Pertahankan shalat dan jadikan kebiasaan harian.";
          reason =
          "Kemampuan shalat sudah sangat baik.";
          estimatedMinutes = 5;
        }

        icon = Icons.mosque;
        color = Colors.teal;
        break;

      case "Dzikir":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai mengenalkan dzikir harian secara bertahap.";
          reason =
          "Anak baru mulai belajar dzikir.";
          estimatedMinutes = 10;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi dzikir agar lebih lancar dan mudah diingat.";
          reason =
          "Engine mendeteksi dzikir masih perlu pengulangan.";
          estimatedMinutes = 10;
        } else if (target.status == "Cukup") {
          description =
          "Perbanyak latihan dzikir agar menjadi kebiasaan.";
          reason =
          "Kemampuan dzikir sudah berkembang dan perlu diperkuat.";
          estimatedMinutes = 8;
        } else if (target.status == "Lancar") {
          description =
          "Biasakan membaca dzikir setiap hari.";
          reason =
          "Dzikir sudah lancar dan perlu dijaga konsistensinya.";
          estimatedMinutes = 5;
        } else {
          description =
          "Pertahankan kebiasaan dzikir harian.";
          reason =
          "Dzikir sudah menjadi kebiasaan yang baik.";
          estimatedMinutes = 5;
        }

        icon = Icons.favorite;
        color = Colors.red;
        break;

      case "Doa":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai menghafal doa harian sesuai aktivitas anak.";
          reason =
          "Anak baru mulai mengenal doa harian.";
          estimatedMinutes = 10;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi doa hingga lebih lancar.";
          reason =
          "Engine mendeteksi hafalan doa masih perlu pengulangan.";
          estimatedMinutes = 10;
        } else if (target.status == "Cukup") {
          description =
          "Latih membaca doa tanpa bantuan.";
          reason =
          "Doa sudah mulai diingat dan perlu diperkuat.";
          estimatedMinutes = 8;
        } else if (target.status == "Lancar") {
          description =
          "Biasakan membaca doa pada waktu yang tepat.";
          reason =
          "Doa sudah lancar dan perlu diamalkan setiap hari.";
          estimatedMinutes = 5;
        } else {
          description =
          "Pertahankan kebiasaan membaca doa harian.";
          reason =
          "Doa telah menjadi kebiasaan yang baik.";
          estimatedMinutes = 5;
        }

        icon = Icons.volunteer_activism;
        color = Colors.orange;
        break;

      case "Hadits":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai mempelajari satu hadits pendek beserta maknanya.";
          reason =
          "Anak baru mulai mengenal hadits.";
          estimatedMinutes = 15;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi hadits hingga hafal dan memahami maknanya.";
          reason =
          "Engine mendeteksi hadits masih perlu pengulangan.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Perkuat hafalan hadits dan mulai mengamalkannya.";
          reason =
          "Hadits sudah berkembang dan perlu diperdalam.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Murajaah hadits agar tetap terjaga.";
          reason =
          "Hadits sudah lancar dan perlu dijaga.";
          estimatedMinutes = 10;
        } else {
          description =
          "Lanjutkan ke hadits berikutnya.";
          reason =
          "Hadits sebelumnya sudah mutqin.";
          estimatedMinutes = 5;
        }

        icon = Icons.library_books;
        color = Colors.indigo;
        break;

      case "Bahasa Arab":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai mengenal kosakata Bahasa Arab dasar.";
          reason =
          "Anak baru mulai belajar Bahasa Arab.";
          estimatedMinutes = 15;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi kosakata yang sudah dipelajari.";
          reason =
          "Kosakata masih perlu diperkuat.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Tambahkan kosakata baru sambil mengulang yang lama.";
          reason =
          "Kemampuan Bahasa Arab mulai berkembang.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Gunakan kosakata dalam percakapan sederhana.";
          reason =
          "Kosakata sudah cukup dikuasai.";
          estimatedMinutes = 10;
        } else {
          description =
          "Lanjutkan ke materi Bahasa Arab berikutnya.";
          reason =
          "Materi sebelumnya sudah mutqin.";
          estimatedMinutes = 5;
        }

        icon = Icons.translate;
        color = Colors.deepPurple;
        break;

      case "Berhitung":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai mengenal konsep berhitung sesuai usia anak.";
          reason =
          "Anak baru mulai belajar berhitung.";
          estimatedMinutes = 15;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi latihan berhitung dengan benda-benda di sekitar.";
          reason =
          "Kemampuan berhitung masih perlu penguatan.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Latih berhitung dengan variasi soal sederhana.";
          reason =
          "Kemampuan berhitung mulai berkembang.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Pertahankan kemampuan berhitung melalui permainan edukatif.";
          reason =
          "Kemampuan berhitung sudah baik.";
          estimatedMinutes = 10;
        } else {
          description =
          "Lanjutkan ke materi berhitung berikutnya.";
          reason =
          "Materi sebelumnya telah dikuasai.";
          estimatedMinutes = 5;
        }

        icon = Icons.calculate;
        color = Colors.blue;
        break;

      case "Motorik Kasar":

        if (target.status == "Belum Dipelajari") {
          description =
          "Mulai aktivitas motorik kasar sesuai usia anak.";
          reason =
          "Anak baru mulai melatih kemampuan motorik kasar.";
          estimatedMinutes = 20;
        } else if (target.status == "Belum Lancar") {
          description =
          "Ulangi aktivitas fisik untuk meningkatkan koordinasi tubuh.";
          reason =
          "Koordinasi tubuh masih perlu dilatih.";
          estimatedMinutes = 20;
        } else if (target.status == "Cukup") {
          description =
          "Tambahkan variasi aktivitas fisik agar lebih percaya diri.";
          reason =
          "Motorik kasar mulai berkembang.";
          estimatedMinutes = 15;
        } else if (target.status == "Lancar") {
          description =
          "Pertahankan aktivitas fisik secara rutin.";
          reason =
          "Kemampuan motorik kasar sudah baik.";
          estimatedMinutes = 10;
        } else {
          description =
          "Lanjutkan dengan tantangan motorik yang lebih beragam.";
          reason =
          "Motorik kasar telah berkembang dengan baik.";
          estimatedMinutes = 5;
        }

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

