class Hafalan {
  final int? id;

  final int childId;

  final String namaSurat;
  final String ayat;

  const Hafalan({
    this.id,
    required this.childId,
    required this.namaSurat,
    required this.ayat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'namaSurat': namaSurat,
      'ayat': ayat,
    };
  }

  factory Hafalan.fromMap(Map<String, dynamic> map) {
    return Hafalan(
      id: map['id'] as int?,
      childId: map['childId'] as int,
      namaSurat: map['namaSurat'] as String,
      ayat: map['ayat'] as String,
    );
  }
}