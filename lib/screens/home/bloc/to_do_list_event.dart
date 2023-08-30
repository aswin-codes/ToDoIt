part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListEvent {}

class ToDoListInitialEvent extends ToDoListEvent {}

class TaskAddEvent extends ToDoListEvent {
  Task task;
  TaskAddEvent({required this.task});
}

class TaskDeleteEvent extends ToDoListEvent {
  Task task;
  TaskDeleteEvent({required this.task});
}

class TaskChangeStatusEvent extends ToDoListEvent {
  Task task;
  TaskChangeStatusEvent({required this.task});
}
