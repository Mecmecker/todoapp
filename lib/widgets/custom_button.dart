import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/listas_provider.dart';

class CustomButton extends StatefulWidget {
  final String title;

  const CustomButton({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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

    return Container(
      margin: const EdgeInsets.only(top: 10, left: 34, right: 34),
      height: 45,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF8C3B),
            Color(0xFFFF6365),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Center(
        child: GestureDetector(
          onTap: openDialog,
          child: Text(
            widget.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: "Netflix",
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
