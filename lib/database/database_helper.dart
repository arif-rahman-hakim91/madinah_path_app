import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance =
  DatabaseHelper._init();

  DatabaseHelper._init();

  Database? _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('madinah_path.db');

    return _database!;

  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      filePath,
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

  }

  Future _createDB(
      Database db,
      int version,
      ) async {

    await db.execute('''
      CREATE TABLE hafalan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namaSurat TEXT NOT NULL,
        ayat TEXT NOT NULL
      )
    ''');

  }

}