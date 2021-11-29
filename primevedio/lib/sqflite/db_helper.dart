import 'dart:async';

import 'package:path/path.dart';
import 'package:primevedio/sqflite/super_hero.dart';
import 'package:sqflite/sqflite.dart';

class HeroDB {
  late Database database;

  // Initialize database
  Future<Database> initDatabase() async {
    database = await openDatabase(
      // Ensure the path is correctly for any platform
      join(await getDatabasesPath(), "hero_database.db"),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE HEROS("
            "name TEXT,"
            ")");
      },

      // Version
      version: 1,
    );

    return database;
  }

  // Check database connected
  Future<Database> getDatabaseConnect() async {
    if (database != null) {
      return database;
    } else {
      return await initDatabase();
    }
  }

  // Show all data
  Future<List<SuperHero>> showAllData() async {
    final Database db = await getDatabaseConnect();
    final List<Map<String, dynamic>> maps = await db.query("HEROS");

    return List.generate(maps.length, (i) {
      return SuperHero(
        name: maps[i]["name"],
      );
    });
  }

  // Insert
  Future<void> insertData(SuperHero hero) async {
    final Database db = await getDatabaseConnect();
    await db.insert(
      "HEROS",
      hero.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update
  Future<void> updateData(SuperHero hero) async {
    final db = await getDatabaseConnect();
    await db.update(
      "HEROS",
      hero.toMap(),
      where: "id = ?",
    );
  }

  // Delete
  Future<void> deleteData(int id) async {
    final db = await getDatabaseConnect();
    await db.delete(
      "HEROS",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
