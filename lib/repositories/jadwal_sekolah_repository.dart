import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/jadwal_sekolah.dart';

class JadwalSekolahRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> add(
      JadwalSekolah jadwal,
      ) async {
    final db = await dbHelper.database;

    return await db.insert(
      'jadwal_sekolah',
      jadwal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JadwalSekolah>> getAll(
      int childId,
      ) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'jadwal_sekolah',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'tanggal ASC, id ASC',
    );

    return result
        .map(JadwalSekolah.fromMap)
        .toList();
  }

  Future<List<JadwalSekolah>> getByDate(
      int childId,
      DateTime tanggal,
      ) async {
    final db = await dbHelper.database;

    final start = DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await db.query(
      'jadwal_sekolah',
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
        .map(JadwalSekolah.fromMap)
        .toList();
  }

  Future<int> update(
      JadwalSekolah jadwal,
      ) async {
    final db = await dbHelper.database;

    return await db.update(
      'jadwal_sekolah',
      jadwal.toMap(),
      where: 'id = ?',
      whereArgs: [jadwal.id],
    );
  }

  Future<int> delete(
      int id,
      ) async {
    final db = await dbHelper.database;

    return await db.delete(
      'jadwal_sekolah',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}