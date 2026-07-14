class Hafalan {

  final String namaSurat;
  final String ayat;

  Hafalan({
    required this.namaSurat,
    required this.ayat,
  });

  Map<String, dynamic> toMap() {

    return {

      'namaSurat': namaSurat,

      'ayat': ayat,

    };

  }

}