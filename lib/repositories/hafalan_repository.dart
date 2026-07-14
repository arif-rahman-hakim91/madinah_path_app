import 'package:sqflite/sqflite.dart';

import '../data/hafalan_data.dart';
import '../database/database_helper.dart';
import '../models/hafalan.dart';

class HafalanRepository {

  final dbHelper = DatabaseHelper.instance;

  Future<void> addSQLite(Hafalan hafalan) async {

    final db = await dbHelper.database;

    await db.insert(
      'hafalan',
      hafalan.toMap());

  }

}