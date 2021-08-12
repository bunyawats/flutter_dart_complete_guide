import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static const String places_table = 'places';

  static Future<sql.Database> _database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      final sql = """ 
        CREATE TABLE $places_table(
          id TEXT PRIMARY KEY,
          title TEXT,
          image TEXT,
          loc_lat REAL,
          loc_lng REAL,
          address TEXT
        )
      """;
      return db.execute(sql);
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    print('call DbHelper.insert');

    final sqlDb = await _database();

    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    print('call DbHelper.getData');

    final sqlDb = await _database();

    return sqlDb.query(table);
  }
}
