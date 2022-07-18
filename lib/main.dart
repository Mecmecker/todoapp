import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/data/listas_provider.dart';
import 'package:todoapp/data/todos_provider.dart';

import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
          'todos': (context) => const TodoScreen(),
          'newtodo': (context) => const NewTodoPage(),
        },
      ),
    );
  }
}
