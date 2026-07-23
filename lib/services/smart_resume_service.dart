import '../models/target.dart';

class SmartResumeService {
  Map<String, int> analyzeCategory(
      List<Target> targets,
      ) {
    final result = <String, int>{};

    for (final target in targets) {
      result[target.kategori] =
          (result[target.kategori] ?? 0) + 1;
    }

    return result;
  }

  List<Target> getCompletedTargets(
      List<Target> targets,
      ) {
    return targets.where(
          (target) => target.isCompleted,
    ).toList();
  }

  List<Target> getPendingTargets(
      List<Target> targets,
      ) {
    return targets.where(
          (target) => !target.isCompleted,
    ).toList();
  }

  String getDominantCategory(
      List<Target> targets,
      ) {
    final analysis = analyzeCategory(
      targets,
    );

    if (analysis.isEmpty) {
      return "";
    }

    String category = "";
    int highest = 0;

    analysis.forEach(
          (key, value) {
        if (value > highest) {
          highest = value;
          category = key;
        }
      },
    );

    return category;
  }

  int getCompletedCount(
      List<Target> targets,
      ) {
    return targets
        .where(
          (target) => target.isCompleted,
    )
        .length;
  }

  int getPendingCount(
      List<Target> targets,
      ) {
    return targets
        .where(
          (target) => !target.isCompleted,
    )
        .length;
  }

  int getTotalCount(
      List<Target> targets,
      ) {
    return targets.length;
  }

  String getStrength(
      List<Target> targets,
      ) {
    final completedTargets =
    getCompletedTargets(
      targets,
    );

    if (completedTargets.isEmpty) {
      return "Mulai belajar secara bertahap.";
    }

    final dominant =
    getDominantCategory(
      completedTargets,
    );

    switch (dominant) {
      case "Murajaah":
      case "Hafalan":
      case "Tilawah":
        return "Kekuatan hari ini berada pada pembelajaran Al-Qur'an.";

      case "Shalat":
      case "Dzikir":
      case "Doa":
      case "Wudhu":
        return "Kekuatan hari ini berada pada pembiasaan ibadah.";

      case "Hadits":
      case "Aqidah":
      case "Fiqih":
      case "Sirah":
        return "Kekuatan hari ini berada pada ilmu Islam.";

      case "Bahasa Arab":
      case "Iqra":
      case "Huruf Hijaiyah":
        return "Kekuatan hari ini berada pada pembelajaran Bahasa Arab.";

      default:
        return "Perkembangan belajar hari ini cukup seimbang.";
    }
  }

  String generateSummary(
      List<Target> targets,
      ) {
    final total = getTotalCount(
      targets,
    );

    final completed = getCompletedCount(
      targets,
    );

    final pending = getPendingCount(
      targets,
    );

    if (total == 0) {
      return "Belum ada target belajar hari ini.";
    }

    final strength = getStrength(
      targets,
    );

    final dominantCategory = getDominantCategory(
      targets,
    );

    if (completed == 0) {
      return "Hari ini fokus pada kategori $dominantCategory.\n\n"
          "Belum ada target yang berhasil diselesaikan.\n\n"
          "Insya Allah, mulai dari satu target terlebih dahulu agar kebiasaan belajar tetap terjaga.";
    }

    if (completed == total) {
      return "Alhamdulillah.\n\n"
          "Seluruh $total target belajar hari ini telah diselesaikan.\n\n"
          "Fokus pembelajaran hari ini berada pada kategori $dominantCategory.\n\n"
          "Semoga Allah memberikan keberkahan dan kemudahan untuk terus istiqamah.";
    }

    return "Alhamdulillah.\n\n"
        "$completed dari $total target telah diselesaikan.\n\n"
        "$strength\n\n"
        "Masih ada $pending target yang dapat dilanjutkan.";
  }
}