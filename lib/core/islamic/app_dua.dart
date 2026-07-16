import 'dua_item.dart';
import 'reference_item.dart';
import 'reference_category.dart';

class AppDua {
  AppDua._();

  static const jazakallahuKhairan = DuaItem(
    arab: "جزاك الله خيرًا",
    latin: "Jazākallāhu Khairan",
    arti: "Semoga Allah membalasmu dengan kebaikan.",
    reference: ReferenceItem(
      category: ReferenceCategory.hadith,
      source: "Sunan At-Tirmidzi",
      number: "2035",
      grade: "Hasan",
      scholar: "Al-Albani",
    ),
  );

  static const barakallahuFik = DuaItem(
    arab: "بارك الله فيك",
    latin: "Bārakallāhu Fīk",
    arti: "Semoga Allah memberkahimu.",
    reference: ReferenceItem(
      category: ReferenceCategory.doa,
      source: "Doa yang dikenal di kalangan ulama",
    ),
  );
}
