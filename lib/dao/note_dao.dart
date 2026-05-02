import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class NoteDao {

  static const table = DatabaseHelper.tableNotes;
  static const columnId = DatabaseHelper.columnId;
  static const columnTitle = DatabaseHelper.columnTitle;
  static const columnText = DatabaseHelper.columnText;
  static const columnPinned = DatabaseHelper.columnPinned;

  NoteDao._privateConstructor();
  static final NoteDao instance = NoteDao._privateConstructor();

  Future<Database> get database async => await DatabaseHelper.instance.database;

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY $columnId DESC');
  }

  Future<List<Map<String, dynamic>>> queryAllOrderPinnedState() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY $columnPinned DESC');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}
