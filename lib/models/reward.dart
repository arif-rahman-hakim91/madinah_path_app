class Reward {
  final int? id;
  final int childId;

  final int point;
  final String title;
  final String description;
  final DateTime createdAt;

  const Reward({
    this.id,
    required this.childId,
    required this.point,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'point': point,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      id: map['id'],
      childId: map['childId'],
      point: map['point'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}