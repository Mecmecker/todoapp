import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/data/listas_provider.dart';

import '../data/todos_provider.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    final scans = listProvider.listas;

    return GridView.builder(
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          Provider.of<ListProvider>(context, listen: false)
              .borrarListaId(scans[i]);
          Provider.of<ListProvider>(context, listen: false).cargarLista();
        },
        child: AspectRatio(
          aspectRatio: 5 / 6,
          child: GestureDetector(
            onTap: () {
              todoProvider.listaId = scans[i].listId;
              todoProvider.cargarTodo();
              Navigator.pushNamed(context, 'todos', arguments: scans[i].name);
            },
            child: Stack(children: [
              Image.asset(
                'assets/postit.png',
                fit: BoxFit.cover,
              ),
              Align(alignment: Alignment.center, child: Text(scans[i].name)),
            ]),
          ),
        ),
      ),
      itemCount: scans.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
  }
}
