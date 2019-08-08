import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/TodoModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    print(documentsDirectory.path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE TodoList ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "created_date INTEGER,"
          "is_checked BIT"
          ")");
    });
  }

  newTodoList(TodoList newTodoList) async {
    final db = await database;
    //get the biggest id in the table
//    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM TodoList");
//    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into TodoList (title,description,created_date,is_checked)"
        " VALUES (?,?,?,?)",
        [newTodoList.title, newTodoList.description, newTodoList.createdDate,newTodoList.isChecked]);
    return raw;
  }

  checkOrUncheck(TodoList todoList) async {
    final db = await database;
    TodoList isChecked = TodoList(
        id: todoList.id,
        title: todoList.title,
        description: todoList.description,
        isChecked: !todoList.isChecked);
    var res = await db.update("TodoList", isChecked.toMap(),
        where: "id = ?", whereArgs: [todoList.id]);
    return res;
  }

  updateTodoList(TodoList todoList) async {
    final db = await database;
    var res = await db.update("TodoList", todoList.toMap(),
        where: "id = ?", whereArgs: [todoList.id]);
    return res;
  }

  getTodoList(int id) async {
    final db = await database;
    var res = await db.query("TodoList", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? TodoList.fromMap(res.first) : null;
  }

  Future<List<TodoList>> getCheckedTodoList() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM TodoList WHERE is_checked=1");
    var res = await db.query("TodoList", where: "is_checked = ? ", whereArgs: [1]);

    List<TodoList> list =
        res.isNotEmpty ? res.map((c) => TodoList.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<TodoList>> getAllTodoList() async {
    final db = await database;
    var res = await db.query("TodoList",orderBy: "created_date DESC" );
    List<TodoList> list =
        res.isNotEmpty ? res.map((c) => TodoList.fromMap(c)).toList() : [];
    return list;
  }

  deleteTodoList(int id) async {
    final db = await database;
    return db.delete("TodoList", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from TodoList");
  }
}
