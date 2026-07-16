import 'reference_category.dart';

class ReferenceItem {
  final ReferenceCategory category;

  final String source;

  final String? number;

  final String? grade;

  final String? scholar;

  const ReferenceItem({
    required this.category,
    required this.source,
    this.number,
    this.grade,
    this.scholar,
  });
}