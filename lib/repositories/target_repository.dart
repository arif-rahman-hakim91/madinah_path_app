import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/target.dart';

class TargetRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Target target) async {
    final db = await dbHelper.database;

    await db.insert(
      'target',
      target.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Target>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'target',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'targetDate ASC',
    );

    return result
        .map((map) => Target.fromMap(map))
        .toList();
  }

  Future<Target?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'target',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Target.fromMap(result.first);
  }

  Future<void> update(Target target) async {
    final db = await dbHelper.database;

    await db.update(
      'target',
      target.toMap(),
      where: 'id = ?',
      whereArgs: [target.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'target',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Target>> getByDate({
    required int childId,
    required DateTime date,
  }) async {
    final db = await dbHelper.database;

    final start = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await db.query(
      'target',
      where: 'childId = ? AND targetDate >= ? AND targetDate < ?',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'id ASC',
    );

    return result
        .map((map) => Target.fromMap(map))
        .toList();
  }

  Future<int> countCompleted(int childId) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM target
      WHERE childId = ?
      AND isCompleted = 1
      ''',
      [childId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> countAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM target
      WHERE childId = ?
      ''',
      [childId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<Map<String, int>> getTodaySummary(int childId) async {
    final db = await dbHelper.database;

    final start = DateTime.now();

    final today = DateTime(
      start.year,
      start.month,
      start.day,
    );

    final tomorrow = today.add(
      const Duration(days: 1),
    );

    final result = await db.rawQuery(
      '''
    SELECT
      COUNT(*) AS total,
      SUM(
        CASE
          WHEN isCompleted = 1 THEN 1
          ELSE 0
        END
      ) AS selesai
    FROM target
    WHERE childId = ?
    AND targetDate >= ?
    AND targetDate < ?
    ''',
      [
        childId,
        today.toIso8601String(),
        tomorrow.toIso8601String(),
      ],
    );

    final row = result.first;

    return {
      "total": row["total"] as int? ?? 0,
      "selesai": row["selesai"] as int? ?? 0,
    };
  }
}