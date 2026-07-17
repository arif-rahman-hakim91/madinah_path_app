import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/child.dart';

class ChildRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> add(Child child) async {
    final db = await dbHelper.database;

    await db.insert(
      'child',
      child.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Child>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query(
      'child',
      orderBy: 'namaLengkap ASC',
    );

    return result
        .map((map) => Child.fromMap(map))
        .toList();
  }

  Future<Child?> getById(int id) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'child',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Child.fromMap(result.first);
  }

  Future<void> update(Child child) async {
    final db = await dbHelper.database;

    await db.update(
      'child',
      child.toMap(),
      where: 'id = ?',
      whereArgs: [child.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'child',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}