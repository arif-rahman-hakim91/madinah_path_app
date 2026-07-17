import '../models/dashboard_data.dart';
import '../models/ibadah.dart';
import '../models/target_ibadah.dart';
import '../repositories/hafalan_repository.dart';
import '../repositories/ibadah_repository.dart';
import '../repositories/target_ibadah_repository.dart';
import 'current_child_service.dart';

class DashboardService {
  final ibadahRepository = IbadahRepository();
  final targetRepository = TargetIbadahRepository();
  final hafalanRepository = HafalanRepository();

  Future<DashboardData> loadDashboard() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      return const DashboardData(
        progress: 0,
        hafalanCount: 0,
        ibadahCount: 0,
        strength: "Belum ada data.",
        improvement: "Belum ada data.",
      );
    }

    final Ibadah? ibadah =
    await ibadahRepository.getToday(child.id!);

    final TargetIbadah? target =
    await targetRepository.getTarget(child.id!);

    final hafalan =
    await hafalanRepository.getAll(child.id!);

    int ibadahCount = 0;

    if (ibadah != null) {
      if (ibadah.subuh) ibadahCount++;
      if (ibadah.dzuhur) ibadahCount++;
      if (ibadah.ashar) ibadahCount++;
      if (ibadah.maghrib) ibadahCount++;
      if (ibadah.isya) ibadahCount++;
      if (ibadah.tilawah) ibadahCount++;
      if (ibadah.dzikir) ibadahCount++;
    }

    double progress = 0;

    if (ibadah != null && target != null) {
      int targetTotal = 0;
      int doneTotal = 0;

      if (target.subuh > 0) {
        targetTotal++;
        if (ibadah.subuh) doneTotal++;
      }

      if (target.dzuhur > 0) {
        targetTotal++;
        if (ibadah.dzuhur) doneTotal++;
      }

      if (target.ashar > 0) {
        targetTotal++;
        if (ibadah.ashar) doneTotal++;
      }

      if (target.maghrib > 0) {
        targetTotal++;
        if (ibadah.maghrib) doneTotal++;
      }

      if (target.isya > 0) {
        targetTotal++;
        if (ibadah.isya) doneTotal++;
      }

      if (target.tilawah > 0) {
        targetTotal++;
        if (ibadah.tilawah) doneTotal++;
      }

      if (target.dzikir > 0) {
        targetTotal++;
        if (ibadah.dzikir) doneTotal++;
      }

      if (targetTotal > 0) {
        progress = doneTotal / targetTotal;
      }
    }

    String strength = "Belum ada data.";

    String improvement = "Belum ada data.";

    if (ibadahCount >= 6) {
      strength = "Masya Allah, ibadah hari ini sangat baik.";
    } else if (ibadahCount >= 4) {
      strength = "Ibadah sudah cukup baik, pertahankan.";
    } else {
      strength = "Mulai membangun kebiasaan ibadah harian.";
    }

    if (hafalan.isEmpty) {
      improvement = "Tambahkan hafalan pertama hari ini.";
    } else if (progress < 0.5) {
      improvement = "Masih ada target ibadah yang belum tercapai.";
    } else {
      improvement = "Pertahankan konsistensi hari ini.";
    }

    return DashboardData(
      progress: progress,
      hafalanCount: hafalan.length,
      ibadahCount: ibadahCount,
      strength: strength,
      improvement: improvement,
    );
  }
}