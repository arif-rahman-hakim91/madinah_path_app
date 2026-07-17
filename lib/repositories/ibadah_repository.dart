import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/ibadah.dart';

class IbadahRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Ibadah ibadah) async {
    final db = await dbHelper.database;

    await db.insert(
      'ibadah',
      ibadah.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ibadah>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'ibadah',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'tanggal DESC',
    );

    return result
        .map((map) => Ibadah.fromMap(map))
        .toList();
  }

  Future<Ibadah?> getToday(int childId) async {
    final db = await dbHelper.database;

    final today = DateTime.now()
        .toIso8601String()
        .substring(0, 10);

    final result = await db.query(
      'ibadah',
      where: 'childId = ? AND substr(tanggal, 1, 10) = ?',
      whereArgs: [
        childId,
        today,
      ],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Ibadah.fromMap(result.first);
  }

  Future<Ibadah?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'ibadah',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Ibadah.fromMap(result.first);
  }

  Future<void> update(Ibadah ibadah) async {
    final db = await dbHelper.database;

    await db.update(
      'ibadah',
      ibadah.toMap(),
      where: 'id = ?',
      whereArgs: [ibadah.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'ibadah',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Ibadah>> getLast7Days(int childId) async {
    final db = await dbHelper.database;

    final now = DateTime.now();

    final startDate = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 6));

    final result = await db.query(
      'ibadah',
      where: 'childId = ? AND tanggal >= ?',
      whereArgs: [
        childId,
        startDate.toIso8601String(),
      ],
      orderBy: 'tanggal ASC',
    );

    return result
        .map((map) => Ibadah.fromMap(map))
        .toList();
  }
}