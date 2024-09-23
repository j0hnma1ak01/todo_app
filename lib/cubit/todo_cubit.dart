import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/model/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  final Box<TodoModel> _todoBox;

  TodoCubit(this._todoBox) : super([]) {
    laodTodos();
  }

  void laodTodos() {
    if (_todoBox.isNotEmpty) {
      emit(_todoBox.values.toList());
    }
  }

  void addTodo(String title) {
    final newTask = TodoModel(title: title, isCompleted: false);
    _todoBox.add(newTask);
    emit([...state, newTask]);
  }

  void update(int index) {
    state[index].isCompleted = !state[index].isCompleted;
    _todoBox.putAt(index, state[index]);
    emit([...state]);
  }

  void deleteTodo(int index) {
    _todoBox.deleteAt(index);
    emit([...state]..removeAt(index));
  }
}
