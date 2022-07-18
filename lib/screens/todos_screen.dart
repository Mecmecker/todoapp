import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/models.dart';
import '../data/todos_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    List<Todo> scans = todoProvider.todos;
    _removeCheck() {
      for (var todo in scans) {
        if (todo.done == true) todoProvider.borrarTodoId(todo);
      }
      setState(() {});
    }

    _maybeRemoveCheck() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Confirmacion'),
                content: const Text('Seguro que quires borrar los marcados?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Borrar'),
                  ),
                ],
              )).then((borrar) {
        if (borrar) _removeCheck();
      });
    }

    final arg = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista ${arg as String}'),
        actions: [
          IconButton(
              onPressed: _maybeRemoveCheck, icon: const Icon(Icons.delete))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'newtodo').then((value) {
            if (value != null) {
              todoProvider.nuevoScan(value.toString());
            }
          });
        },
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 233, 226, 135)),
          ),
          ListView.builder(
            itemBuilder: (_, int i) => InkWell(
              onTap: () {
                setState(() {
                  scans[i].toggleDone();
                });
              },
              child: ListTile(
                leading: Checkbox(
                  value: scans[i].done,
                  onChanged: (checked) {
                    setState(() {
                      scans[i].done = checked!;
                    });
                  },
                ),
                title: Text(
                  scans[i].what,
                  style: TextStyle(
                    decoration: (scans[i].done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
                  ),
                ),
              ),
            ),
            itemCount: scans.length,
          ),
        ],
      ),
    );
  }
}
