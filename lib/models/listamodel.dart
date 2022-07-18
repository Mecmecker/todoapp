class ListaModel {
  String name;

  int? listId;
  ListaModel({required this.name, listId});

  ListaModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        listId = json['listaId'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'listaId': listId,
      };
}
