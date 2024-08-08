import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../models/journal_entry.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static var SQL_CREATE_FILE = 'assets/files/schema_1.sql.txt';
  static const String SQL_INSERT =
      'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';
  static const SQL_SELECT = 'SELECT * FROM journal_entries';

  static DatabaseManager _instance = DatabaseManager._();
  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }
  final Database db;
  DatabaseManager._({Database? database}) : db = database!;

  static Future initialize() async {
    String SQL_CREATE_SCHEMA = await rootBundle.loadString(SQL_CREATE_FILE);
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, SQL_CREATE_SCHEMA);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(
          SQL_INSERT, [dto.title, dto.body, dto.rating, dto.dateTime.toString()]);
    });
  }

  Future<List<JournalEntry>> journalEntries() async {
    final journalRecords = await db.rawQuery(SQL_SELECT);
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'] as String,
          body: record['body'] as String,
          rating: record['rating'] as int,
          date: record['date'] as String);
    }).toList();
    return journalEntries;
  }
}
