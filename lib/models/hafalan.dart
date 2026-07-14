class Hafalan {
  final int? id;
  final String namaSurat;
  final String ayat;

  Hafalan({
    this.id,
    required this.namaSurat,
    required this.ayat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaSurat': namaSurat,
      'ayat': ayat,
    };
  }

  factory Hafalan.fromMap(Map<String, dynamic> map) {
    return Hafalan(
      id: map['id'] as int?,
      namaSurat: map['namaSurat'] as String,
      ayat: map['ayat'] as String,
    );
  }
}