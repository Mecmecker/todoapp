import 'package:flutter/material.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/widgets/widgets.dart';

import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseRepository database = DatabaseRepository.instance;

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
                const Center(
                  child: CustomButton(title: 'Nueva lista'),
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
}
