import 'arabic_text.dart';
import 'reference_item.dart';

abstract class IslamicContent {
  final ArabicText text;

  final ReferenceItem reference;

  const IslamicContent({
    required this.text,
    required this.reference,
  });
}