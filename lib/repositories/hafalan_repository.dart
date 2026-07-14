import '../data/hafalan_data.dart';
import '../models/hafalan.dart';
import '../models/hafalan.dart';

class HafalanRepository {
  List<Hafalan> getAll() {
    return daftarHafalan;
  }

  void add(Hafalan hafalan) {
    daftarHafalan.add(hafalan);
  }

  void delete(Hafalan hafalan) {
    daftarHafalan.remove(hafalan);
  }
}