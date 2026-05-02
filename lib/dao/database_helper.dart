import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static const _databaseName = "DayStudy.db";
  static const _databaseVersion = 1;

  // Notes
  static const tableNotes = 'notes';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnText = 'text';
  static const columnPinned = 'pinned';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async =>
      _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''    
           CREATE TABLE $tableNotes (
             $columnId INTEGER PRIMARY KEY,
             $columnTitle TEXT NOT NULL,
             $columnText TEXT NOT NULL,
             $columnPinned INTEGER NOT NULL
          )          
          ''');
  }
}
