import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/daily_target.dart';

class DailyTargetRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(
      DailyTarget dailyTarget,
      ) async {
    final db = await dbHelper.database;

    await db.insert(
      'daily_target',
      dailyTarget.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  Future<List<DailyTarget>> getTodayTargets(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await db.query(
      'daily_target',
      where: '''
      childId = ?
      AND tanggal >= ?
      AND tanggal < ?
      ''',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'id ASC',
    );

    return result
        .map(
      DailyTarget.fromMap,
    )
        .toList();
  }

  Future<bool> hasTodayTargets(
      int childId,
      ) async {
    final total =
    await countTodayTargets(
      childId,
    );

    return total > 0;
  }

  Future<void> update(
      DailyTarget dailyTarget,
      ) async {
    final db = await dbHelper.database;

    await db.update(
      'daily_target',
      dailyTarget.toMap(),
      where: 'id = ?',
      whereArgs: [
        dailyTarget.id,
      ],
    );
  }
  Future<void> deleteTodayTargets(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    await db.delete(
      'daily_target',
      where: '''
      childId = ?
      AND tanggal >= ?
      AND tanggal < ?
      ''',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );
  }

  Future<int> countCompletedToday(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM daily_target
      WHERE childId = ?
      AND isCompleted = 1
      AND tanggal >= ?
      AND tanggal < ?
      ''',
      [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> countTodayTargets(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM daily_target
      WHERE childId = ?
      AND tanggal >= ?
      AND tanggal < ?
      ''',
      [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<Map<String, int>> getTodaySummary(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
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
    FROM daily_target
    WHERE childId = ?
    AND tanggal >= ?
    AND tanggal < ?
    ''',
      [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );

    final row = result.first;

    return {
      "total": row["total"] as int? ?? 0,
      "selesai": row["selesai"] as int? ?? 0,
    };
  }

  Future<List<DateTime>> getLearningDates(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      '''
    SELECT DISTINCT tanggal
    FROM daily_target
    WHERE childId = ?
    ORDER BY tanggal DESC
    ''',
      [
        childId,
      ],
    );

    return result.map(
          (row) {
        return DateTime.parse(
          row['tanggal'].toString(),
        );
      },
    ).toList();
  }

  Future<List<DailyTarget>> getHistoryByDate(
      int childId,
      DateTime date,
      ) async {
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
      'daily_target',
      where: '''
      childId = ?
      AND tanggal >= ?
      AND tanggal < ?
    ''',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'id ASC',
    );

    return result
        .map(
      DailyTarget.fromMap,
    )
        .toList();
  }

  Future<List<DailyTarget>> getLast7Days(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(
      const Duration(days: 6),
    );

    final end = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(
      const Duration(days: 1),
    );

    final result = await db.query(
      'daily_target',
      where: '''
      childId = ?
      AND tanggal >= ?
      AND tanggal < ?
    ''',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'tanggal ASC',
    );

    return result
        .map(
      DailyTarget.fromMap,
    )
        .toList();
  }

  Future<List<DailyTarget>> getLast30Days(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(
      const Duration(days: 29),
    );

    final end = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(
      const Duration(days: 1),
    );

    final result = await db.query(
      'daily_target',
      where: '''
      childId = ?
      AND tanggal >= ?
      AND tanggal < ?
    ''',
      whereArgs: [
        childId,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'tanggal ASC',
    );

    return result
        .map(
      DailyTarget.fromMap,
    )
        .toList();
  }

  Future<void> updateCompletion({
    required int dailyTargetId,
    required bool isCompleted,
  }) async {
    final db = await dbHelper.database;

    await db.update(
      'daily_target',
      {
        'isCompleted': isCompleted ? 1 : 0,
        'completedAt': isCompleted
            ? DateTime.now().toIso8601String()
            : null,
      },
      where: 'id = ?',
      whereArgs: [dailyTargetId],
    );
  }

  Future<List<DailyTarget>> getTodayByChild(
      int childId,
      ) async {
    return getTodayTargets(
      childId,
    );
  }


}