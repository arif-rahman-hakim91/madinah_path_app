import 'arabic_text.dart';
import 'reference_item.dart';
import 'hadith_grade.dart';

class HadithItem {
  final ArabicText text;

  final ReferenceItem reference;

  final HadithGrade grade;

  const HadithItem({
    required this.text,
    required this.reference,
    required this.grade,
  });
}