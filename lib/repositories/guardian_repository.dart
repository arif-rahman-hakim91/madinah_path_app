import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/guardian.dart';

class GuardianRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> save(Guardian guardian) async {
    final db = await dbHelper.database;

    await db.insert(
      'guardian',
      guardian.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Guardian?> getGuardian() async {
    final db = await dbHelper.database;

    final result = await db.query(
      'guardian',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Guardian.fromMap(result.first);
  }

  Future<void> update(Guardian guardian) async {
    final db = await dbHelper.database;

    await db.update(
      'guardian',
      guardian.toMap(),
      where: 'id = ?',
      whereArgs: [guardian.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'guardian',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}