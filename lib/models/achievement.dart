class Achievement {
  final int? id;
  final int childId;

  final String title;
  final String description;

  final String icon;

  final DateTime unlockedAt;

  const Achievement({
    this.id,
    required this.childId,
    required this.title,
    required this.description,
    required this.icon,
    required this.unlockedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'title': title,
      'description': description,
      'icon': icon,
      'unlockedAt': unlockedAt.toIso8601String(),
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'],
      childId: map['childId'],
      title: map['title'],
      description: map['description'],
      icon: map['icon'],
      unlockedAt: DateTime.parse(map['unlockedAt']),
    );
  }
}