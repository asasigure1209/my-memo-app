import 'package:my_memo_app/memo/memo.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initializeDB() async {
  String path = await getDatabasesPath();
  return openDatabase(
    '${path}memo_database.db',
    onCreate: (database, version) async {
      await database.execute(
        "CREATE TABLE memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, updated_at TEXT, created_at TEXT, content TEXT)",
      );
    },
    version: 1,
  );
}

Future<void> insertMemo(Database db, Memo memo) async {
  await db.insert(
    'memos',
    memo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateRecord(Memo memo) async {
  Database db = await initializeDB();
  await db.update(
    'memos',
    memo.toMap(),
    where: 'id = ?',
    whereArgs: [memo.id],
  );
}

Future<List<Memo>> getMemos() async {
  Database db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query('memos');

  return List.generate(maps.length, (i) {
    return Memo(
      id: maps[i]['id'],
      title: maps[i]['title'],
      updatedAt: maps[i]['updated_at'],
      createdAt: maps[i]['created_at'],
      content: maps[i]['content'],
    );
  });
}
