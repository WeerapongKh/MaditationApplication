import 'package:maditation/model/date.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "Date.db"),
      onCreate: (database, version) async {
        await database.execute("""
            CREATE TABLE DateTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            day TEXT NOT NULL, 
            minute TEXT NOT NULL)
            """);
      },
      version: 1,
    );
  }

  Future<bool> insertData(DataModel dataModel) async {
    final Database db = await initDB();
    db.insert("DateTable", dataModel.toMap());
    return true;
  }

  Future<List<DataModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> data = await db.query("DateTable");
    return data.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<void> update(DataModel dataModel, int id) async {
    final Database db = await initDB();
    await db
        .update("DateTable", dataModel.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final Database db = await initDB();
    await db.delete("DateTable", where: "id=?", whereArgs: [id]);
  }

  Future<int?> countDay() async {
    final Database db = await initDB();

    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM DateTable'));
    print("count = $count ");
    return count;
  }
}
