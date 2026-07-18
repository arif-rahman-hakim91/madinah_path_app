import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/reward.dart';

class RewardRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Reward reward) async {
    final db = await dbHelper.database;

    await db.insert(
      'reward',
      reward.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Reward>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'reward',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'createdAt DESC',
    );

    return result
        .map((map) => Reward.fromMap(map))
        .toList();
  }

  Future<Reward?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'reward',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Reward.fromMap(result.first);
  }

  Future<void> update(Reward reward) async {
    final db = await dbHelper.database;

    await db.update(
      'reward',
      reward.toMap(),
      where: 'id = ?',
      whereArgs: [reward.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'reward',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getTotalPoint(int childId) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(point) AS total
      FROM reward
      WHERE childId = ?
      ''',
      [childId],
    );

    final total = result.first['total'];

    if (total == null) {
      return 0;
    }

    return total as int;
  }
}