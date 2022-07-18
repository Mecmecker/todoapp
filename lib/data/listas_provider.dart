import 'package:flutter/cupertino.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/models/models.dart';

class ListProvider extends ChangeNotifier {
  List<ListaModel> listas = [];

  ListProvider() {
    cargarLista();
  }

  Future<ListaModel> nuevoScan(String name) async {
    final nuevoLista = ListaModel(name: name);
    final id = await DatabaseRepository.instance.createLista(nuevoLista);
    nuevoLista.listId = id;

    listas.add(nuevoLista);
    notifyListeners();

    return nuevoLista;
  }

  cargarLista() async {
    final lista = await DatabaseRepository.instance.getAllListas();
    listas = [...lista];
    notifyListeners();
  }

  borrarListaId(ListaModel lista) async {
    await DatabaseRepository.instance.deleteLista(lista);
    // cargarScanTipos(tipoSelect);
  }

  modificarListaId(ListaModel lista) async {
    await DatabaseRepository.instance.updateLista(lista);
  }
}
