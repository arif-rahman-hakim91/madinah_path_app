class Guardian {
  final int? id;

  final String nama;
  final String panggilan;
  final String? email;
  final String? nomorHp;
  final String? foto;
  final String? pin;

  const Guardian({
    this.id,
    required this.nama,
    required this.panggilan,
    this.email,
    this.nomorHp,
    this.foto,
    this.pin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'panggilan': panggilan,
      'email': email,
      'nomorHp': nomorHp,
      'foto': foto,
      'pin': pin,
    };
  }

  factory Guardian.fromMap(Map<String, dynamic> map) {
    return Guardian(
      id: map['id'],
      nama: map['nama'],
      panggilan: map['panggilan'],
      email: map['email'],
      nomorHp: map['nomorHp'],
      foto: map['foto'],
      pin: map['pin'],
    );
  }
}