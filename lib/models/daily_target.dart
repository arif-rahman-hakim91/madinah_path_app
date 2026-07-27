class DailyTarget {
  final int? id;

  final int childId;

  final int targetId;

  final DateTime tanggal;

  final bool isCompleted;

  final DateTime? completedAt;

  final DateTime createdAt;

  const DailyTarget({
    this.id,
    required this.childId,
    required this.targetId,
    required this.tanggal,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
  });

  DailyTarget copyWith({
    int? id,
    int? childId,
    int? targetId,
    DateTime? tanggal,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
  }) {
    return DailyTarget(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      targetId: targetId ?? this.targetId,
      tanggal: tanggal ?? this.tanggal,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'targetId': targetId,
      'tanggal': tanggal.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'completedAt': completedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DailyTarget.fromMap(
      Map<String, dynamic> map,
      ) {
    return DailyTarget(
      id: map['id'],
      childId: map['childId'],
      targetId: map['targetId'],
      tanggal: DateTime.parse(
        map['tanggal'],
      ),
      isCompleted: map['isCompleted'] == 1,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(
        map['completedAt'],
      )
          : null,
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }
}