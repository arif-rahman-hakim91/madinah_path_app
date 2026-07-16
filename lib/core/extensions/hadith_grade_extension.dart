import '../islamic/hadith_grade.dart';

extension HadithGradeExtension on HadithGrade {
  String get arabic => switch (this) {
    HadithGrade.sahih => "صحيح",
    HadithGrade.hasan => "حسن",
    HadithGrade.dhaif => "ضعيف",
    HadithGrade.mawdu => "موضوع",
    HadithGrade.mauquf => "موقوف",
    HadithGrade.maqthu => "مقطوع",
  };

  String get indonesia => switch (this) {
    HadithGrade.sahih => "Shahih",
    HadithGrade.hasan => "Hasan",
    HadithGrade.dhaif => "Dha'if",
    HadithGrade.mawdu => "Maudhu'",
    HadithGrade.mauquf => "Mauquf",
    HadithGrade.maqthu => "Maqthu'",
  };

  String get english => switch (this) {
    HadithGrade.sahih => "Authentic",
    HadithGrade.hasan => "Good",
    HadithGrade.dhaif => "Weak",
    HadithGrade.mawdu => "Fabricated",
    HadithGrade.mauquf => "Stopped",
    HadithGrade.maqthu => "Disconnected",
  };
}