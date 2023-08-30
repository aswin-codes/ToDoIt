part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListState {}

class ToDoListActionState extends ToDoListState {}

final class ToDoListInitial extends ToDoListState {}

class ToDoListInitialLoadingState extends ToDoListState {}

class ToDoListSuccessState extends ToDoListState {
  List<Task> list;
  ToDoListSuccessState({required this.list});
}

class ToDoListError extends ToDoListState{
  
}
