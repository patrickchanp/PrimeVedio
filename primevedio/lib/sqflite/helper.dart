import 'dart:async';
import 'dart:core';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:primevedio/sqflite/search_history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  //单例设计模式
  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");
    var theDb = await openDatabase(path, version: 2, onCreate: _onCreate,
        onUpgrade: (db, oldVersion, newVerison) {
      db.execute('');
    });
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE searchValue(searchWord text not null )");
    print("Created tables");
  }

  void saveSearchValue(SearchValue searchValue) async {
    var dbClient = await db;
    print(dbClient);
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('''
          INSERT INTO searchValue(searchWord ) VALUES(
          
          '${searchValue.searchWord}'
          );
        ''');
    });
  }

  void deleteSearchValue() async {
    var dbClient = await db;
    await dbClient.delete('searchValue');
  }

  Future<List<SearchValue>> getSearchValues() async {
    var dbClient = await db;
    List<Map> list = await dbClient.query('searchValue');
    return list.map((e) => SearchValue.fromMap(e)).toList();
  }
}
