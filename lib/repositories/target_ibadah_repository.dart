import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/target_ibadah.dart';

class TargetIbadahRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> save(TargetIbadah target) async {
    final db = await dbHelper.database;

    await db.insert(
      'target_ibadah',
      target.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<TargetIbadah?> getTarget(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'target_ibadah',
      where: 'childId = ?',
      whereArgs: [childId],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return TargetIbadah.fromMap(result.first);
  }

  Future<void> update(TargetIbadah target) async {
    final db = await dbHelper.database;

    await db.update(
      'target_ibadah',
      target.toMap(),
      where: 'id = ?',
      whereArgs: [target.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'target_ibadah',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}