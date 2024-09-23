import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_title.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/data/model/todo_model.dart';

class HomePage extends StatefulWidget {
  final Box<TodoModel>? todoBox; // Make the box optional

  const HomePage({super.key, this.todoBox});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todoList = [];
  late final Box<TodoModel> _myBox;
  var todoDataBase = TodoDatabase();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myBox = widget.todoBox ??
        Hive.box<TodoModel>('todobox'); // Use default box if not provided
    if (_myBox.isNotEmpty) {
      todoList = todoDataBase.loadTodos();
    }
  }

  void onCheckBoxChanged(bool? newValue, int index) {
    setState(() {
      todoList[index].isCompleted = !todoList[index].isCompleted;
      _myBox.putAt(index, todoList[index]);
    });
  }

  void saveNewTask() {
    setState(() {
      var newTask = TodoModel(title: _controller.text, isCompleted: false);
      todoList.add(newTask);
      todoDataBase.addTodo(newTask);
    });
    _controller.clear();
    Navigator.pop(context);
  }

  void cancelDialog() {
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: cancelDialog);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ToDo App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/Settings");
            },
            icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.settings, size: 24.0),
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        //backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
        ),
        child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todoList[index].title),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    todoList.removeAt(index);
                    _myBox.deleteAt(index);
                    todoList = todoDataBase.loadTodos();
                  });
                },
                child: TodoTitle(
                  title: todoList[index].title,
                  taskCompleted: todoList[index].isCompleted,
                  onChanged: (value) => onCheckBoxChanged(value, index),
                ),
              );
            }),
      ),
    );
  }
}
