
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReminderDb {
  static Database? _db;

  static Future<Database> instance() async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'reminders.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
          CREATE TABLE reminders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            medicineId TEXT NOT NULL,
            time TEXT NOT NULL,
            days TEXT NOT NULL,
            frequency TEXT NOT NULL,
            createdAt INTEGER NOT NULL,
            UNIQUE(medicineId, time, days) ON CONFLICT REPLACE
          )
        ''');
      },
    );

    return _db!;
  }
}