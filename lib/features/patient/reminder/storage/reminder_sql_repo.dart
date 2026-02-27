import 'package:sqflite/sqflite.dart';

import 'reminder_db.dart';

class ReminderSqlRepo {
  Future<void> upsertMany(List<Map<String, dynamic>> rows) async {
    final db = await ReminderDb.instance();
    final batch = db.batch();
    for (final r in rows) {
      batch.insert('reminders', r, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await ReminderDb.instance();
    return db.query('reminders', orderBy: 'createdAt DESC');
  }

  Future<void> deleteByMedicineId(String medicineId) async {
    final db = await ReminderDb.instance();
    await db.delete('reminders', where: 'medicineId=?', whereArgs: [medicineId]);
  }

  Future<void> deleteOne({
    required String medicineId,
    required String time,
    required String days,
  }) async {
    final db = await ReminderDb.instance();
    await db.delete(
      'reminders',
      where: 'medicineId=? AND time=? AND days=?',
      whereArgs: [medicineId, time, days],
    );
  }

  Future<void> clear() async {
    final db = await ReminderDb.instance();
    await db.delete('reminders');
  }
}