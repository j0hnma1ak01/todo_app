import 'package:flutter/material.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/settings.dart';
import 'package:todo_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  final todoBox = await Hive.openBox<TodoModel>("todobox");
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(todoBox: todoBox),
  ));
}

class MyApp extends StatelessWidget {
  final Box<TodoModel>? todoBox;

  const MyApp({super.key, this.todoBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: HomePage(
          todoBox: todoBox ??
              Hive.box<TodoModel>("todobox")), // Use default box if null
      routes: {
        '/Settings': (context) => const Settings(),
      },
    );
  }
}
