import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final root = await getDatabasesPath();
    _db = await openDatabase(p.join(root, 'samirnet_video.db'), version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE downloads(
          id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, url TEXT NOT NULL,
          platform TEXT NOT NULL, status TEXT NOT NULL, file_path TEXT,
          size_bytes INTEGER, format TEXT, quality TEXT, duration_seconds INTEGER,
          created_at TEXT NOT NULL, error TEXT)''');
        await db.execute('''CREATE TABLE settings(key TEXT PRIMARY KEY, value TEXT NOT NULL)''');
      });
    return _db!;
  }

  Future<int> addDownload({required String title, required String url, required String platform, String status='queued'}) async {
    return (await database).insert('downloads', {'title':title,'url':url,'platform':platform,'status':status,'created_at':DateTime.now().toIso8601String()});
  }
  Future<List<Map<String,Object?>>> downloads({String? status}) async => (await database).query('downloads', where: status == null ? null : 'status = ?', whereArgs: status == null ? null : [status], orderBy:'created_at DESC');
  Future<void> updateDownload(int id, Map<String,Object?> values) async => (await database).update('downloads', values, where:'id = ?', whereArgs:[id]);
  Future<void> deleteDownload(int id) async => (await database).delete('downloads', where:'id = ?', whereArgs:[id]);
  Future<String?> getSetting(String key) async => (await database).query('settings', columns:['value'], where:'key = ?', whereArgs:[key], limit:1).then((rows)=>rows.isEmpty ? null : rows.first['value'] as String);
  Future<void> setSetting(String key, String value) async => (await database).insert('settings', {'key':key,'value':value}, conflictAlgorithm:ConflictAlgorithm.replace);
}