import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/reward.dart';

class RewardRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(
      Reward reward,
      ) async {
    final db = await dbHelper.database;

    await db.insert(
      'reward',
      reward.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  Future<List<Reward>> getAll(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'reward',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'createdAt DESC',
    );

    return result
        .map(Reward.fromMap)
        .toList();
  }

  Future<int> getTotalPoint(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(point) AS total
      FROM reward
      WHERE childId = ?
      ''',
      [childId],
    );

    return Sqflite.firstIntValue(
      result,
    ) ??
        0;
  }
}