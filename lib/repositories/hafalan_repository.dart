import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/hafalan.dart';

class HafalanRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Hafalan hafalan) async {
    final db = await dbHelper.database;

    await db.insert(
      'hafalan',
      hafalan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Hafalan>> getAll(int childId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'hafalan',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'id DESC',
    );

    return result.map((e) => Hafalan.fromMap(e)).toList();
  }

  Future<void> update(Hafalan hafalan) async {
    final db = await dbHelper.database;

    await db.update(
      'hafalan',
      hafalan.toMap(),
      where: 'id = ?',
      whereArgs: [hafalan.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'hafalan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}