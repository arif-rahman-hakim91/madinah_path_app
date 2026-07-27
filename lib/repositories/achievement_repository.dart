import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/achievement.dart';

class AchievementRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(
      Achievement achievement,
      ) async {
    final db = await dbHelper.database;

    await db.insert(
      'achievement',
      achievement.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  Future<List<Achievement>> getAll(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'achievement',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'unlockedAt DESC',
    );

    return result
        .map(
      Achievement.fromMap,
    )
        .toList();
  }

  Future<bool> exists({
    required int childId,
    required String title,
  }) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'achievement',
      where:
      'childId = ? AND title = ?',
      whereArgs: [
        childId,
        title,
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<void> delete(
      int id,
      ) async {
    final db = await dbHelper.database;

    await db.delete(
      'achievement',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}