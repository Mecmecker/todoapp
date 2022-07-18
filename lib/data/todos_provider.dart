import 'package:flutter/cupertino.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/models/models.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todos = [];
  int? listaId;

  Future<Todo> nuevoScan(String name) async {
    final nuevoTodo = Todo(what: name, listId: listaId!);
    final id = await DatabaseRepository.instance.createTodo(nuevoTodo);
    nuevoTodo.todoId = id;

    todos.add(nuevoTodo);
    notifyListeners();

    return nuevoTodo;
  }

  cargarTodo() async {
    final todo = await DatabaseRepository.instance.getAllTodoById(listaId!);
    todos = [...todo];
    notifyListeners();
  }

  borrarTodoId(Todo todo) async {
    await DatabaseRepository.instance.deleteTodo(todo);
    cargarTodo();
    // cargarScanTipos(tipoSelect);
  }

  modificarListaId(Todo todo) async {
    await DatabaseRepository.instance.updateTodo(todo);
    cargarTodo();
  }
}
