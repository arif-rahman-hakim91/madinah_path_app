class Target {
  final int? id;

  final int childId;

  final String nama;

  final String kategori;

  final bool isCompleted;

  final DateTime targetDate;

  final DateTime createdAt;

  final DateTime updatedAt;

  final String status;

  const Target({
    this.id,
    required this.childId,
    required this.nama,
    required this.kategori,
    required this.isCompleted,
    required this.targetDate,
    required this.createdAt,
    required this.updatedAt,
    this.status = "Belum Dipelajari",
  });

  Target copyWith({
    int? id,
    int? childId,
    String? nama,
    String? kategori,
    bool? isCompleted,
    DateTime? targetDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) {
    return Target(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      isCompleted: isCompleted ?? this.isCompleted,
      targetDate: targetDate ?? this.targetDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'nama': nama,
      'kategori': kategori,
      'status': status,
      'isCompleted': isCompleted ? 1 : 0,
      'targetDate': targetDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Target.fromMap(Map<String, dynamic> map) {
    return Target(
      id: map['id'],
      childId: map['childId'],
      nama: map['nama'],
      kategori: map['kategori'],
      status: map['status'] ?? "Belum Dipelajari",
      isCompleted: map['isCompleted'] == 1,
      targetDate: DateTime.parse(map['targetDate']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}