import '../models/target.dart';

class LearningFlowService {
  List<Target> generateFlow(
      List<Target> targets,
      ) {
    final result = <Target>[];

    result.addAll(
      targets.where(
            (e) => e.kategori == "Murajaah",
      ),
    );

    result.addAll(
      targets.where(
            (e) => e.kategori == "Hafalan",
      ),
    );

    result.addAll(
      targets.where(
            (e) => e.kategori == "Mutqin",
      ),
    );

    result.addAll(
      targets.where(
            (e) =>
        e.kategori != "Murajaah" &&
            e.kategori != "Hafalan" &&
            e.kategori != "Mutqin",
      ),
    );

    return result;
  }
}