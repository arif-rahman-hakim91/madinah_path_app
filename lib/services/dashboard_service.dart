import '../models/ibadah.dart';
import '../models/target_ibadah.dart';
import '../repositories/ibadah_repository.dart';
import '../repositories/target_ibadah_repository.dart';

class DashboardService {
  final ibadahRepository = IbadahRepository();
  final targetRepository = TargetIbadahRepository();

  Future<double> getTodayProgress() async {
    final Ibadah? ibadah = await ibadahRepository.getToday();
    final TargetIbadah? target = await targetRepository.getTarget();

    if (ibadah == null || target == null) {
      return 0;
    }

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

    if (targetTotal == 0) {
      return 0;
    }

    return doneTotal / targetTotal;
  }

  Future<int> getTodayIbadahCount() async {
    final Ibadah? ibadah = await ibadahRepository.getToday();

    if (ibadah == null) {
      return 0;
    }

    int total = 0;

    if (ibadah.subuh) total++;
    if (ibadah.dzuhur) total++;
    if (ibadah.ashar) total++;
    if (ibadah.maghrib) total++;
    if (ibadah.isya) total++;
    if (ibadah.tilawah) total++;
    if (ibadah.dzikir) total++;

    return total;
  }

  Future<int> getTodayHafalanCount() async {
    final db = await ibadahRepository.dbHelper.database;

    final result = await db.query('hafalan');

    return result.length;
  }
}