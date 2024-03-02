import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/main.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<CreateTask>(onCreateTask);
    on<FetchTask>(onFetchTask);
    
  }

  Future<void> onCreateTask(CreateTask event, Emitter<TaskState> emit) async{
    final List<Task> taskList = state.taskList;
    emit(TaskLoading());
    taskList.add(event.task);
    emit(TaskLoaded(taskList: taskList));
  }

  Future<void> onFetchTask(FetchTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    //since there is no backend to fetch task from we return an empty list
    emit(TaskLoaded(taskList: []));
  }
}
