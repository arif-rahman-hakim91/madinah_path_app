class JadwalSekolah {
  final int? id;
  final int childId;

  final DateTime tanggal;
  final String kategori;
  final String judul;
  final String? deskripsi;

  final DateTime createdAt;
  final DateTime updatedAt;

  const JadwalSekolah({
    this.id,
    required this.childId,
    required this.tanggal,
    required this.kategori,
    required this.judul,
    this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'tanggal': tanggal.toIso8601String(),
      'kategori': kategori,
      'judul': judul,
      'deskripsi': deskripsi,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory JadwalSekolah.fromMap(
      Map<String, dynamic> map,
      ) {
    return JadwalSekolah(
      id: map['id'],
      childId: map['childId'],
      tanggal: DateTime.parse(
        map['tanggal'],
      ),
      kategori: map['kategori'],
      judul: map['judul'],
      deskripsi: map['deskripsi'],
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      updatedAt: DateTime.parse(
        map['updatedAt'],
      ),
    );
  }
}