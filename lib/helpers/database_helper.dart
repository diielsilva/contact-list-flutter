import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> openConnection() async {
    String path = await getDatabasesPath();
    String completePath = join(path, "contact_list.db");
    Database database = await openDatabase(completePath, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          "CREATE TABLE contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, phone TEXT NOT NULL)");
    });
    return database;
  }
}
