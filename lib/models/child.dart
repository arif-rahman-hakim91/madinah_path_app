class Child {
  final int? id;

  final int guardianId;

  final String namaLengkap;
  final String namaPanggilan;

  final DateTime tanggalLahir;

  final String jenisKelamin;

  final String? foto;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Child({
    this.id,
    required this.guardianId,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.tanggalLahir,
    required this.jenisKelamin,
    this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guardianId': guardianId,
      'namaLengkap': namaLengkap,
      'namaPanggilan': namaPanggilan,
      'tanggalLahir': tanggalLahir.toIso8601String(),
      'jenisKelamin': jenisKelamin,
      'foto': foto,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id'],
      guardianId: map['guardianId'],
      namaLengkap: map['namaLengkap'],
      namaPanggilan: map['namaPanggilan'],
      tanggalLahir: DateTime.parse(map['tanggalLahir']),
      jenisKelamin: map['jenisKelamin'],
      foto: map['foto'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}