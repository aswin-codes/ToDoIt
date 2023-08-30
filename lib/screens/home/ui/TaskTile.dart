import 'package:flutter/material.dart';
import 'package:todoit/screens/home/bloc/to_do_list_bloc.dart';
import 'package:todoit/screens/home/model/Task.dart';

class TaskTile extends StatelessWidget {
  ToDoListBloc toDoListBloc;
  Task task;
  TaskTile({super.key, required this.task, required this.toDoListBloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        toDoListBloc.add(TaskChangeStatusEvent(task: task));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: task.isDone ? Colors.green : Colors.yellow,
        ),
        child: ListTile(
          title: Text(task.title),
          trailing: IconButton(
            onPressed: () {
              toDoListBloc.add(TaskDeleteEvent(task: task));
            },
            icon: Icon(
              Icons.delete,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
