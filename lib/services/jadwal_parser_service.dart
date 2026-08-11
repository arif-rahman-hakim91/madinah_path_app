class JadwalParserService {
  static const List<String> kategoriBawaan = [
    "Hafalan",
    "Iqra",
    "Huruf",
    "Angka",
    "Doa",
    "Mufradat",
    "Adab",
    "Kegiatan",
  ];

  List<JadwalParserItem> parse(String text) {
    final lines = text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final List<JadwalParserItem> hasil = [];

    DateTime? tanggalSekarang;
    String? kategoriSekarang;
    final List<String> materi = [];

    void simpanMateri() {
      if (tanggalSekarang == null ||
          kategoriSekarang == null ||
          materi.isEmpty) {
        materi.clear();
        return;
      }

      hasil.add(
        JadwalParserItem(
          tanggal: tanggalSekarang,
          kategori: kategoriSekarang,
          judul: materi.join(' '),
        ),
      );

      materi.clear();
    }

    for (final line in lines) {
      final tanggal = _cariTanggal(line);

      if (tanggal != null) {
        simpanMateri();

        tanggalSekarang = tanggal;
        kategoriSekarang = null;

        continue;
      }

      final kategori = _cariKategori(line);

      if (kategori != null) {
        simpanMateri();

        kategoriSekarang = kategori;

        continue;
      }

      if (tanggalSekarang != null &&
          kategoriSekarang != null) {
        materi.add(line);
      }
    }

    simpanMateri();

    return hasil;
  }

  DateTime? _cariTanggal(String line) {
    final normalized = line
        .toLowerCase()
        .replaceAll(',', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    final match = RegExp(
      r'(\d{1,2})\s+'
      r'(januari|februari|maret|april|mei|juni|juli|'
      r'agustus|september|oktober|november|desember)'
      r'(?:\s+(\d{4}))?',
    ).firstMatch(normalized);

    if (match == null) {
      return null;
    }

    final hari = int.parse(match.group(1)!);
    final namaBulan = match.group(2)!;
    final tahun = match.group(3) == null
        ? DateTime.now().year
        : int.parse(match.group(3)!);

    const bulan = {
      "januari": 1,
      "februari": 2,
      "maret": 3,
      "april": 4,
      "mei": 5,
      "juni": 6,
      "juli": 7,
      "agustus": 8,
      "september": 9,
      "oktober": 10,
      "november": 11,
      "desember": 12,
    };

    final nomorBulan = bulan[namaBulan];

    if (nomorBulan == null) {
      return null;
    }

    return DateTime(
      tahun,
      nomorBulan,
      hari,
    );
  }

  String? _cariKategori(String line) {
    final normalized = line
        .toLowerCase()
        .replaceAll(':', '')
        .trim();

    for (final kategori in kategoriBawaan) {
      if (normalized == kategori.toLowerCase()) {
        return kategori;
      }
    }

    return null;
  }
}

class JadwalParserItem {
  DateTime? tanggal;
  String kategori;
  String judul;
  bool jadikanTarget;

  JadwalParserItem({
    this.tanggal,
    required this.kategori,
    required this.judul,
    this.jadikanTarget = false,
  });
}