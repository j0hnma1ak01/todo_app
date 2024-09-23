import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/model/todo_model.dart';

class TodoDatabase {
  //List todolist = [];

  final _myBox = Hive.box<TodoModel>('todobox');

  // void loadData() {
  //   //todolist = _myBox.get('todoList');
  // }

  // void updateDataBase() {
  //   //_myBox.put('todoList', todolist);
  // }

  void addTodo(TodoModel todomodel) {
    _myBox.add(todomodel);
  }

  List<TodoModel> loadTodos() {
    return _myBox.values.toList();
  }
}
