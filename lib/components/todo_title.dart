import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoTitle extends StatelessWidget {
  final String title;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  TodoTitle(
      {super.key,
      required this.title,
      required this.taskCompleted,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        color: const Color.fromARGB(248, 142, 142, 139),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        child: Center(
          child: ListTile(
            leading: Checkbox(value: taskCompleted, onChanged: onChanged),
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}
