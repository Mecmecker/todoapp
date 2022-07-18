class Todo {
  late String what;
  late bool done;
  late int listId;
  int? todoId;
  Todo({required this.what, required this.listId, todoId}) : done = false;

  Todo.fromJson(Map<String, dynamic> json)
      : what = json['what'],
        listId = json['FK_todos_listas'],
        done = json['done'] == 1 ? true : false,
        todoId = json['todoId'];

  Map<String, dynamic> toJson() => {
        'what': what,
        'FK_todos_listas': listId,
        'done': done,
        'todoId': todoId,
      };

  void toggleDone() => done = !done;
}
