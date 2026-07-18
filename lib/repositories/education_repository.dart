import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/education.dart';

class EducationRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Education education) async {
    final db = await dbHelper.database;

    await db.insert(
      'education',
      education.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Education>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'education',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'tanggalMulai DESC',
    );

    return result
        .map((map) => Education.fromMap(map))
        .toList();
  }

  Future<Education?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'education',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Education.fromMap(result.first);
  }

  Future<void> update(Education education) async {
    final db = await dbHelper.database;

    await db.update(
      'education',
      education.toMap(),
      where: 'id = ?',
      whereArgs: [education.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'education',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}