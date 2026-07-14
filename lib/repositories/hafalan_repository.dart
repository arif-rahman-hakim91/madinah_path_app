import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/hafalan.dart';

class HafalanRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Hafalan hafalan) async {
    final db = await dbHelper.database;

    await db.insert(
      'hafalan',
      hafalan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Hafalan>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query(
      'hafalan',
      orderBy: 'id DESC',
    );

    return result
        .map((map) => Hafalan.fromMap(map))
        .toList();
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'hafalan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}