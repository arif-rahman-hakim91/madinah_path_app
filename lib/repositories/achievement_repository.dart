import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/achievement.dart';

class AchievementRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Achievement achievement) async {
    final db = await dbHelper.database;

    await db.insert(
      'achievement',
      achievement.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Achievement>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'achievement',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'unlockedAt DESC',
    );

    return result
        .map((map) => Achievement.fromMap(map))
        .toList();
  }

  Future<Achievement?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'achievement',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Achievement.fromMap(result.first);
  }

  Future<void> update(Achievement achievement) async {
    final db = await dbHelper.database;

    await db.update(
      'achievement',
      achievement.toMap(),
      where: 'id = ?',
      whereArgs: [achievement.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'achievement',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> exists(
      int childId,
      String title,
      ) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'achievement',
      where: 'childId = ? AND title = ?',
      whereArgs: [
        childId,
        title,
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}