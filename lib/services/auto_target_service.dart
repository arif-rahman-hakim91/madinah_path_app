import '../models/child.dart';
import '../models/target.dart';
import '../repositories/target_repository.dart';

class AutoTargetService {
  final TargetRepository repository = TargetRepository();

  static const Map<String, int> priority = {
    "Murajaah": 1,
    "Hafalan": 2,
    "Mutqin": 3,
    "Tilawah": 4,

    "Shalat": 5,
    "Dzikir": 6,
    "Doa": 7,
    "Wudhu": 8,

    "Hadits": 9,
    "Aqidah": 10,
    "Fiqih": 11,
    "Sirah": 12,
    "Asmaul Husna": 13,

    "Adab": 14,
    "Akhlak": 15,

    "Huruf Hijaiyah": 16,
    "Iqra": 17,
    "Bahasa Arab": 18,
    "Membaca": 19,

    "Berhitung": 20,
    "Warna": 21,
    "Bentuk": 22,
    "Pola": 23,

    "Motorik Halus": 24,
    "Motorik Kasar": 25,

    "Kemandirian": 26,
    "Life Skill": 27,
    "Proyek Amal": 28,
  };

  static const Map<String, int> difficulty = {
    "Belum Dipelajari": 1,
    "Belum Lancar": 2,
    "Cukup": 3,
    "Lancar": 4,
    "Mutqin": 5,
  };

  int getDailyTargetCount(
      Child child,
      ) {
    // TODO:
    // Nanti disesuaikan berdasarkan
    // umur atau tingkat belajar.

    return 5;
  }
// Menghapus target yang sudah Mutqin.
  List<Target> filterPendingTargets(
      List<Target> targets,
      ) {
    return targets.where(
          (target) => target.status != "Mutqin",
    ).toList();
  }
// Menghapus target yang sudah selesai hari ini.
  List<Target> removeCompletedToday(
      List<Target> targets,
      List<Target> completedToday,
      ) {
    final completedIds = completedToday
        .map((e) => e.id)
        .toSet();

    return targets.where(
          (target) {
        return !completedIds.contains(target.id);
      },
    ).toList();
  }

// Mengutamakan target Al-Qur'an.

// Menyeimbangkan target Qur'an, Ibadah, dan kategori lain.
  List<Target> balanceTargets(
      List<Target> targets,
      ) {
    final quran = <Target>[];
    final ibadah = <Target>[];
    final others = <Target>[];

    for (final target in targets) {
      switch (target.kategori) {
        case "Murajaah":
        case "Hafalan":
        case "Tilawah":
          quran.add(target);
          break;

        case "Shalat":
        case "Dzikir":
        case "Doa":
        case "Wudhu":
          ibadah.add(target);
          break;

        default:
          others.add(target);
      }
    }

    return [
      ...quran,
      ...ibadah,
      ...others,
    ];
  }
// Menghindari kategori yang sama muncul berurutan.
  List<Target> diversifyTargets(
      List<Target> targets,
      ) {
    final result = <Target>[];
    final usedCategory = <String>{};

    for (final target in targets) {
      if (!usedCategory.contains(target.kategori)) {
        result.add(target);
        usedCategory.add(target.kategori);
      }
    }

    for (final target in targets) {
      if (!result.contains(target)) {
        result.add(target);
      }
    }

    return result;
  }
// Membatasi jumlah target harian.
  List<Target> limitTargets(
      Child child,
      List<Target> targets,
      ) {
    return targets
        .take(
      getDailyTargetCount(child),
    )
        .toList();
  }
// Menghitung skor setiap target.
  int calculateScore(
      Target target,
      ) {
    int score = 0;

    score += (priority[target.kategori] ?? 999) * -10;

    score += (difficulty[target.status] ?? 999) * -5;

    final reviewDays =
        DateTime.now()
            .difference(target.updatedAt)
            .inDays;

    score += reviewDays;

    return score;
  }
// Mengurutkan target berdasarkan skor.
  List<Target> sortByScore(
      List<Target> targets,
      ) {
    targets.sort(
          (a, b) =>
          calculateScore(b)
              .compareTo(calculateScore(a)),
    );

    return targets;
  }

  // ======================================================
// AUTO DAILY TARGET GENERATOR
//
// Pipeline:
//
// 1. Ambil semua target anak
// 2. Filter target yang belum Mutqin
// 3. Hapus target yang sudah selesai hari ini
// 4. Hitung Smart Score
// 5. Prioritaskan target Al-Qur'an
// 6. Seimbangkan kategori belajar
// 7. Variasikan kategori
// 8. Batasi jumlah target harian
//
// Output:
// List<Target>
// ======================================================

  Future<List<Target>> generateTodayTargets(
      Child child,
      ) async {
    final targets = await repository.getAllByChild(
      child.id!,
    );

    final pendingTargets = filterPendingTargets(
      targets,
    );

    final completedToday =
    await repository.getCompletedToday(
      child.id!,
    );

    final availableTargets =
    removeCompletedToday(
      pendingTargets,
      completedToday,
    );

    final scoredTargets = sortByScore(
      availableTargets,
    );

    final balancedTargets =
    balanceTargets(
      scoredTargets,
    );

    final diversifiedTargets =
    diversifyTargets(
      balancedTargets,
    );

    final todayTargets = limitTargets(
      child,
      diversifiedTargets,
    );

    return todayTargets;
  }
}