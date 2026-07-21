import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('madinah_path.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 11,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE hafalan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        namaSurat TEXT NOT NULL,
        ayat TEXT NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ibadah(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        tanggal TEXT NOT NULL,
        subuh INTEGER NOT NULL,
        dzuhur INTEGER NOT NULL,
        ashar INTEGER NOT NULL,
        maghrib INTEGER NOT NULL,
        isya INTEGER NOT NULL,
        tilawah INTEGER NOT NULL,
        dzikir INTEGER NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE target_ibadah(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        subuh INTEGER NOT NULL,
        dzuhur INTEGER NOT NULL,
        ashar INTEGER NOT NULL,
        maghrib INTEGER NOT NULL,
        isya INTEGER NOT NULL,
        tilawah INTEGER NOT NULL,
        dzikir INTEGER NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE guardian(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namaLengkap TEXT NOT NULL,
        namaPanggilan TEXT NOT NULL,
        jenisKelamin TEXT NOT NULL,
        email TEXT,
        nomorHp TEXT,
        foto TEXT,
        pin TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE child(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        guardianId INTEGER NOT NULL,
        namaLengkap TEXT NOT NULL,
        namaPanggilan TEXT NOT NULL,
        tanggalLahir TEXT NOT NULL,
        jenisKelamin TEXT NOT NULL,
        foto TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        FOREIGN KEY (guardianId) REFERENCES guardian(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE education(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        jenjang TEXT NOT NULL,
        namaSekolah TEXT NOT NULL,
        namaGuru TEXT NOT NULL,
        catatan TEXT NOT NULL,
        tanggalMulai TEXT NOT NULL,
        tanggalSelesai TEXT,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE reward(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        point INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE achievement(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        icon TEXT NOT NULL,
        unlockedAt TEXT NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE target(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        childId INTEGER NOT NULL,
        nama TEXT NOT NULL,
        kategori TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        targetDate TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        FOREIGN KEY (childId) REFERENCES child(id)
      )
    ''');
  }

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ibadah(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tanggal TEXT NOT NULL,
          subuh INTEGER NOT NULL,
          dzuhur INTEGER NOT NULL,
          ashar INTEGER NOT NULL,
          maghrib INTEGER NOT NULL,
          isya INTEGER NOT NULL,
          tilawah INTEGER NOT NULL,
          dzikir INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS target_ibadah(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          subuh INTEGER NOT NULL,
          dzuhur INTEGER NOT NULL,
          ashar INTEGER NOT NULL,
          maghrib INTEGER NOT NULL,
          isya INTEGER NOT NULL,
          tilawah INTEGER NOT NULL,
          dzikir INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS guardian(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          namaLengkap TEXT NOT NULL,
          namaPanggilan TEXT NOT NULL,
          jenisKelamin TEXT NOT NULL,
          email TEXT,
          nomorHp TEXT,
          foto TEXT,
          pin TEXT,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )
      ''');
    }

    if (oldVersion < 5) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS child(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          guardianId INTEGER NOT NULL,
          namaLengkap TEXT NOT NULL,
          namaPanggilan TEXT NOT NULL,
          tanggalLahir TEXT NOT NULL,
          jenisKelamin TEXT NOT NULL,
          foto TEXT,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL,
          FOREIGN KEY (guardianId) REFERENCES guardian(id)
        )
      ''');
    }

    if (oldVersion < 6) {
      await db.execute('''
        ALTER TABLE hafalan
        ADD COLUMN childId INTEGER NOT NULL DEFAULT 1
      ''');
    }

    if (oldVersion < 7) {
      await db.execute('''
        ALTER TABLE ibadah
        ADD COLUMN childId INTEGER NOT NULL DEFAULT 1
      ''');

      await db.execute('''
        ALTER TABLE target_ibadah
        ADD COLUMN childId INTEGER NOT NULL DEFAULT 1
      ''');
    }

    if (oldVersion < 8) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS education(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          childId INTEGER NOT NULL,
          jenjang TEXT NOT NULL,
          namaSekolah TEXT NOT NULL,
          namaGuru TEXT NOT NULL,
          catatan TEXT NOT NULL,
          tanggalMulai TEXT NOT NULL,
          tanggalSelesai TEXT,
          FOREIGN KEY (childId) REFERENCES child(id)
        )
      ''');
    }

    if (oldVersion < 9) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS reward(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          childId INTEGER NOT NULL,
          point INTEGER NOT NULL,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          FOREIGN KEY (childId) REFERENCES child(id)
        )
      ''');
    }

    if (oldVersion < 10) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS achievement(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          childId INTEGER NOT NULL,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          icon TEXT NOT NULL,
          unlockedAt TEXT NOT NULL,
          FOREIGN KEY (childId) REFERENCES child(id)
        )
      ''');
    }

    if (oldVersion < 11) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS target(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          childId INTEGER NOT NULL,
          nama TEXT NOT NULL,
          kategori TEXT NOT NULL,
          isCompleted INTEGER NOT NULL,
          targetDate TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL,
          FOREIGN KEY (childId) REFERENCES child(id)
        )
      ''');
    }
  }
}