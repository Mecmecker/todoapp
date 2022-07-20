import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class DatabaseRepository {
  static Database? _database;
  static final DatabaseRepository instance = DatabaseRepository._();

  DatabaseRepository._();

  final _databaseName = 'listaDatabase.db';
  final _databaseVersion = 2;

  Future<Database?> get database async {
    if (_database == null) return await _initDatabase();

    return _database;
  }

  _initDatabase() async {
    Directory documents = await getApplicationDocumentsDirectory();
    final path = join(documents.path + _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS todos (
            todoId INTEGER PRIMARY KEY AUTOINCREMENT,
            what STRING NOT NULL,
            done BOOLEAN NOT NULL,
            FK_todos_listas INTEGER NOT NULL,
            FOREIGN KEY (FK_todos_listas) REFERENCES listas (listaId)
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS listas (
            listaId INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL
          )
          ''');
    });
  }

  Future<int> createLista(ListaModel lista) async {
    final db = await database;
    final res = await db!.insert('listas', lista.toJson());
    return res;
  }

  Future<int> deleteLista(ListaModel lista) async {
    final db = await database;
    final res = await db!
        .delete('listas', where: 'listaId=?', whereArgs: [lista.listId]);
    return res;
  }

  Future<int> updateLista(ListaModel lista) async {
    final db = await database;
    final res = await db!.update('listas', lista.toJson(),
        where: 'listaId=?', whereArgs: [lista.listId]);
    return res;
  }

  Future<List<ListaModel>> getAllListas() async {
    final db = await database;
    final allRows = await db!.query('listas');

    return allRows.isNotEmpty
        ? allRows.map((lista) => ListaModel.fromJson(lista)).toList()
        : [];
  }

  Future<int> createTodo(Todo todo) async {
    final db = await database;
    final res = await db!.insert('todos', todo.toJson());
    return res;
  }

  Future<int> deleteTodo(Todo todo) async {
    final db = await database;
    final res =
        await db!.delete('todos', where: 'todoId=?', whereArgs: [todo.todoId]);
    return res;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    final res = await db!.update('todos', todo.toJson(),
        where: 'todoId=?', whereArgs: [todo.todoId]);
    return res;
  }

  Future<List<Todo>> getAllTodoById(int id) async {
    final db = await database;
    final allRows =
        await db!.query('todos', where: 'FK_todos_listas = ?', whereArgs: [id]);

    return allRows.isNotEmpty
        ? allRows.map((todos) => Todo.fromJson(todos)).toList()
        : [];
  }

  Future<void> deleteDatabase() async {
    Directory documents = await getApplicationDocumentsDirectory();
    final path = join(documents.path + _databaseName);
    databaseFactory.deleteDatabase(path);
  }

  Future<List<Todo>> todoHelp(String suggest) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db!.query('todos',
        where: 'what LIKE ?',
        whereArgs: ['%$suggest%'],
        distinct: true,
        groupBy: 'what');

    return allRows.isNotEmpty
        ? allRows.map((todos) => Todo.fromJson(todos)).toList()
        : [];
  }
}
