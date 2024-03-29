import 'dart:async';
import 'package:flutter_personal/repository/database.dart';
import 'package:flutter_personal/repository/models/todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  Future<List<Todo>> getTodos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(todoTABLE,
            columns: columns,
            where: 'isDone LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db.update(todoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  Future<int> deleteTodo(String id) async {
    final db = await dbProvider.database;
    var result = await db.delete(todoTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      todoTABLE,
    );

    return result;
  }
}