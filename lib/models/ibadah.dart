class Ibadah {
  final int? id;

  final int childId;

  final DateTime tanggal;

  final bool subuh;
  final bool dzuhur;
  final bool ashar;
  final bool maghrib;
  final bool isya;

  final bool tilawah;
  final bool dzikir;

  const Ibadah({
    this.id,
    required this.childId,
    required this.tanggal,
    required this.subuh,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.tilawah,
    required this.dzikir,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'tanggal': tanggal.toIso8601String(),
      'subuh': subuh ? 1 : 0,
      'dzuhur': dzuhur ? 1 : 0,
      'ashar': ashar ? 1 : 0,
      'maghrib': maghrib ? 1 : 0,
      'isya': isya ? 1 : 0,
      'tilawah': tilawah ? 1 : 0,
      'dzikir': dzikir ? 1 : 0,
    };
  }

  factory Ibadah.fromMap(Map<String, dynamic> map) {
    return Ibadah(
      id: map['id'] as int?,
      childId: map['childId'] as int,
      tanggal: DateTime.parse(map['tanggal'] as String),
      subuh: map['subuh'] == 1,
      dzuhur: map['dzuhur'] == 1,
      ashar: map['ashar'] == 1,
      maghrib: map['maghrib'] == 1,
      isya: map['isya'] == 1,
      tilawah: map['tilawah'] == 1,
      dzikir: map['dzikir'] == 1,
    );
  }
}