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
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE hafalan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namaSurat TEXT NOT NULL,
        ayat TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ibadah(
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

    await db.execute('''
      CREATE TABLE target_ibadah(
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
  }
}