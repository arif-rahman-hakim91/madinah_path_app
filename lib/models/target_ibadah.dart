class TargetIbadah {
  final int? id;

  final int subuh;
  final int dzuhur;
  final int ashar;
  final int maghrib;
  final int isya;

  final int tilawah;
  final int dzikir;

  const TargetIbadah({
    this.id,
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
      'subuh': subuh,
      'dzuhur': dzuhur,
      'ashar': ashar,
      'maghrib': maghrib,
      'isya': isya,
      'tilawah': tilawah,
      'dzikir': dzikir,
    };
  }

  factory TargetIbadah.fromMap(Map<String, dynamic> map) {
    return TargetIbadah(
      id: map['id'],
      subuh: map['subuh'],
      dzuhur: map['dzuhur'],
      ashar: map['ashar'],
      maghrib: map['maghrib'],
      isya: map['isya'],
      tilawah: map['tilawah'],
      dzikir: map['dzikir'],
    );
  }
}