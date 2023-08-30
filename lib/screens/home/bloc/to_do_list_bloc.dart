import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoit/screens/home/TaskList.dart';
import 'package:todoit/screens/home/model/Task.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  ToDoListBloc() : super(ToDoListInitial()) {
    on<ToDoListInitialEvent>(toDoListInitialEvent);
    on<TaskAddEvent>(taskAddEvent);
    on<TaskDeleteEvent>(taskDeleteEvent);
    on<TaskChangeStatusEvent>(taskChangeStatusEvent);
  }

  Future<FutureOr<void>> toDoListInitialEvent(
      ToDoListInitialEvent event, Emitter<ToDoListState> emit) async {
    emit(ToDoListInitialLoadingState());
    await Future.delayed(Duration(seconds: 3));
    taskList.sort(
      (a, b) => a.isDone.toString().compareTo(b.isDone.toString()),
    );
    emit(ToDoListSuccessState(list: taskList));
  }

  FutureOr<void> taskAddEvent(TaskAddEvent event, Emitter<ToDoListState> emit) {
    taskList.add(event.task);
    taskList.sort(
      (a, b) => a.isDone.toString().compareTo(b.isDone.toString()),
    );
    emit(ToDoListSuccessState(list: taskList));
  }

  FutureOr<void> taskDeleteEvent(
      TaskDeleteEvent event, Emitter<ToDoListState> emit) {
    taskList.remove(event.task);
    taskList.sort(
      (a, b) => a.isDone.toString().compareTo(b.isDone.toString()),
    );
    emit(ToDoListSuccessState(list: taskList));
  }

  FutureOr<void> taskChangeStatusEvent(
      TaskChangeStatusEvent event, Emitter<ToDoListState> emit) {
    Task task = taskList.firstWhere((element) => element == event.task);
    task.isDone = !task.isDone;
    taskList.sort(
      (a, b) => a.isDone.toString().compareTo(b.isDone.toString()),
    );
    emit(ToDoListSuccessState(list: taskList));
  }
}
