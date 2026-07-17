class TargetIbadah {
  final int? id;

  final int childId;

  final int subuh;
  final int dzuhur;
  final int ashar;
  final int maghrib;
  final int isya;

  final int tilawah;
  final int dzikir;

  const TargetIbadah({
    this.id,
    required this.childId,
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
      id: map['id'] as int?,
      childId: map['childId'] as int,
      subuh: map['subuh'] as int,
      dzuhur: map['dzuhur'] as int,
      ashar: map['ashar'] as int,
      maghrib: map['maghrib'] as int,
      isya: map['isya'] as int,
      tilawah: map['tilawah'] as int,
      dzikir: map['dzikir'] as int,
    );
  }
}