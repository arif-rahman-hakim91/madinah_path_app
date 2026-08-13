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

  static const List<String> hariBawaan = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Ahad",
  ];

  List<JadwalParserItem> parse(String text) {
    final lines = text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final List<JadwalParserItem> hasil = [];

    DateTime? tanggalSekarang;
    String? hariSekarang;

    String? kategoriSekarang;
    String? judulSekarang;

    void simpanMateri() {
      if (kategoriSekarang == null ||
          judulSekarang == null ||
          judulSekarang!.trim().isEmpty) {
        return;
      }

      hasil.add(
        JadwalParserItem(
          tanggal: tanggalSekarang,
          hari: hariSekarang,
          kategori: kategoriSekarang!,
          judul: judulSekarang!.trim(),
        ),
      );

      kategoriSekarang = null;
      judulSekarang = null;
    }

    for (final line in lines) {
      final tanggal = _cariTanggal(line);

      if (tanggal != null) {
        simpanMateri();
        tanggalSekarang = tanggal;
        continue;
      }

      final hari = _cariHari(line);

      if (hari != null) {
        simpanMateri();
        hariSekarang = hari;
        continue;
      }

      final kategoriInline = _cariKategoriInline(line);

      if (kategoriInline != null) {
        simpanMateri();

        kategoriSekarang = kategoriInline.kategori;
        judulSekarang = kategoriInline.judul;

        continue;
      }

      final kategoriBaris = _cariKategori(line);

      if (kategoriBaris != null) {
        simpanMateri();

        kategoriSekarang = kategoriBaris;
        judulSekarang = null;

        continue;
      }

      if (kategoriSekarang != null) {
        if (judulSekarang == null) {
          judulSekarang = line;
        } else {
          judulSekarang =
          "$judulSekarang $line";
        }
      }
    }

    simpanMateri();

    hasil.sort(
          (a, b) {
        return _urutanHari(a.hari)
            .compareTo(_urutanHari(b.hari));
      },
    );

    return hasil;
  }

  String? _cariHari(String line) {
    final normalized = line
        .toLowerCase()
        .replaceAll(':', '')
        .trim();

    for (final hari in hariBawaan) {
      if (normalized == hari.toLowerCase()) {
        return hari;
      }
    }

    return null;
  }

  int _urutanHari(String? hari) {
    if (hari == null) {
      return 99;
    }

    final index = hariBawaan.indexOf(hari);

    return index == -1 ? 99 : index;
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

  _KategoriHasil? _cariKategoriInline(String line) {
    final normalized = line.trim();

    final match = RegExp(
      r"^(hafalan|iqra|mengenal huruf|mengenal angka|doa|do'a|mufradat|adab|kegiatan)\s*:\s*(.*)$",
      caseSensitive: false,
    ).firstMatch(normalized);

    if (match == null) {
      return null;
    }

    final label = match.group(1)!
        .toLowerCase()
        .trim();

    final judul = match.group(2)!
        .trim();

    String kategori;

    switch (label) {
      case "hafalan":
        kategori = "Hafalan";
        break;

      case "iqra":
        kategori = "Iqra";
        break;

      case "mengenal huruf":
        kategori = "Huruf";
        break;

      case "mengenal angka":
        kategori = "Angka";
        break;

      case "doa":
      case "do'a":
        kategori = "Doa";
        break;

      case "mufradat":
        kategori = "Mufradat";
        break;

      case "adab":
        kategori = "Adab";
        break;

      case "kegiatan":
        kategori = "Kegiatan";
        break;

      default:
        return null;
    }

    return _KategoriHasil(
      kategori: kategori,
      judul: judul,
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

class _KategoriHasil {
  final String kategori;
  final String judul;

  const _KategoriHasil({
    required this.kategori,
    required this.judul,
  });
}

class JadwalParserItem {
  DateTime? tanggal;

  final String? hari;

  String kategori;
  String judul;
  bool jadikanTarget;

  JadwalParserItem({
    this.tanggal,
    this.hari,
    required this.kategori,
    required this.judul,
    this.jadikanTarget = false,
  });
}