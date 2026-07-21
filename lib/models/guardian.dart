class Guardian {
  final int? id;

  final String namaLengkap;
  final String namaPanggilan;
  final String jenisKelamin;

  final String? email;
  final String? nomorHp;
  final String? foto;
  final String? pin;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Guardian({
    this.id,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.jenisKelamin,
    this.email,
    this.nomorHp,
    this.foto,
    this.pin,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaLengkap': namaLengkap,
      'namaPanggilan': namaPanggilan,
      'jenisKelamin': jenisKelamin,
      'email': email,
      'nomorHp': nomorHp,
      'foto': foto,
      'pin': pin,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Guardian copyWith({
    int? id,
    String? namaLengkap,
    String? namaPanggilan,
    String? jenisKelamin,
    String? email,
    String? nomorHp,
    String? foto,
    String? pin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Guardian(
      id: id ?? this.id,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      namaPanggilan: namaPanggilan ?? this.namaPanggilan,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      email: email ?? this.email,
      nomorHp: nomorHp ?? this.nomorHp,
      foto: foto ?? this.foto,
      pin: pin ?? this.pin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Guardian.fromMap(Map<String, dynamic> map) {
    return Guardian(
      id: map['id'],
      namaLengkap: map['namaLengkap'],
      namaPanggilan: map['namaPanggilan'],
      jenisKelamin: map['jenisKelamin'],
      email: map['email'],
      nomorHp: map['nomorHp'],
      foto: map['foto'],
      pin: map['pin'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}