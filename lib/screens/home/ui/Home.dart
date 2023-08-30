import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoit/screens/home/bloc/to_do_list_bloc.dart';
import 'package:todoit/screens/home/model/Task.dart';
import 'package:todoit/screens/home/ui/TaskTile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  ToDoListBloc toDoListBloc = ToDoListBloc();

  @override
  void initState() {
    // TODO: implement initState
    toDoListBloc.add(ToDoListInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ToDoIt",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<ToDoListBloc, ToDoListState>(
        bloc: toDoListBloc,
        listenWhen: (previous, current) => previous is ToDoListActionState,
        buildWhen: (previous, current) => previous is! ToDoListActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case ToDoListInitialLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            case ToDoListSuccessState:
              var successState = state as ToDoListSuccessState;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: successState.list.length,
                        itemBuilder: (context, index) {
                          return TaskTile(
                            toDoListBloc: toDoListBloc,
                            task: successState.list[index],
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 310,
                          child: TextField(
                            onSubmitted: (value) {
                              toDoListBloc.add(TaskAddEvent(
                                  task: Task(isDone: false, title: value)));
                              controller.clear();
                            },
                            controller: controller,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                fillColor: Colors.grey,
                                filled: true,
                                hintText: "Add a Task",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              toDoListBloc.add(TaskAddEvent(
                                  task: Task(
                                      isDone: false, title: controller.text)));
                              controller.clear();
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                              size: 40,
                            ))
                      ],
                    ),
                  ),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
