import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DBHandler{

  Database? _database;

  // Create File and table
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'todo.db');
    _database = await openDatabase(path,version: 1,onCreate:(db, version) {
      db.execute(
        '''
        CREATE TABLE TodoTable(
        id INTEGER PRIMARY KEY,
        title TEXT ,
        description TEXT,
        checkbox INTEGER
        )
        '''
      );
    }, );
    return _database;
  }

  // insert the data into table
  insert(TodoModel todoModel) async{
    Database? db = await database;
    final values = todoModel.toMap();
    db!.insert('TodoTable', values);
  }

  //read Data
  Future<List<TodoModel>> read() async{
    Database? db = await database;
    List<Map<String, Object?>> list = await  db!.query('TodoTable');
    return list.map((map) => TodoModel.fromMap(map)).toList();
  }

  delete(int id)async {
    Database? db = await database;
    await db!.delete(
        'TodoTable',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  update(Map<String, dynamic> dataRow) async{
    Database? db = await database;
    int id = dataRow['id'];
    await db!.update('TodoTable', dataRow , where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TodoModel>> searchItems(String query) async{
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query(
        'TodoTable',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'title ASC'
    );
    return maps.map((map) => TodoModel.fromMap(map)).toList();
  }

}