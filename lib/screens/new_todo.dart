import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/todos_provider.dart';
import '../models/models.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({Key? key}) : super(key: key);

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New todo..'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (what) => Navigator.of(context).pop(what),
              onChanged: (value) {
                if (value != '') todoProvider.suggestions(value);
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      todoProvider.nuevoScan(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Text('Siguiente'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_controller.text);
                  },
                  child: const Text('Añadir'),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: todoProvider.suggestionStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  final List<Todo> todos = snapshot.data!;

                  return ListView.separated(
                      itemBuilder: ((context, index) => GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pop(todos[index].what),
                            child: ListTile(
                              title: Text(todos[index].what),
                            ),
                          )),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(color: Colors.grey, height: 2),
                      itemCount: todos.length);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
