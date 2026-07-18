class Education {
  final int? id;

  final int childId;

  final String jenjang;

  final String namaSekolah;

  final String namaGuru;

  final String catatan;

  final DateTime tanggalMulai;

  final DateTime? tanggalSelesai;

  const Education({
    this.id,
    required this.childId,
    required this.jenjang,
    required this.namaSekolah,
    required this.namaGuru,
    required this.catatan,
    required this.tanggalMulai,
    this.tanggalSelesai,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'jenjang': jenjang,
      'namaSekolah': namaSekolah,
      'namaGuru': namaGuru,
      'catatan': catatan,
      'tanggalMulai': tanggalMulai.toIso8601String(),
      'tanggalSelesai': tanggalSelesai?.toIso8601String(),
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id'],
      childId: map['childId'],
      jenjang: map['jenjang'],
      namaSekolah: map['namaSekolah'],
      namaGuru: map['namaGuru'],
      catatan: map['catatan'],
      tanggalMulai: DateTime.parse(map['tanggalMulai']),
      tanggalSelesai: map['tanggalSelesai'] != null
          ? DateTime.parse(map['tanggalSelesai'])
          : null,
    );
  }
}