import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/data/listas_provider.dart';
import 'package:todoapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseRepository database = DatabaseRepository.instance;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ListProvider provider = Provider.of<ListProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child:
                    Image.asset('assets/fondolibreta.png', fit: BoxFit.cover)),
            Column(
              children: [
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 45, 150),
                      elevation: 2,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Nueva Lista',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: openDialog,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 35),
                    width: double.infinity - 80,
                    child: const ScanTiles(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void aceptar() {
    Navigator.of(context).pop(controller.text);
  }

  void cancelar() {
    Navigator.of(context).pop();
  }

  Future<String?> openDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nombre Lista'),
        content: TextField(
          controller: controller,
          decoration:
              const InputDecoration(hintText: 'Entra el nombre de la lista'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: aceptar,
            child: const Text('Aceptar'),
          ),
          TextButton(
            onPressed: cancelar,
            child: const Text('Cancelar'),
          ),
        ],
      ),
    ).then((value) {
      if (value != null) {
        Provider.of<ListProvider>(context, listen: false).nuevoScan(value);
      }
      return null;
    });
  }
}
