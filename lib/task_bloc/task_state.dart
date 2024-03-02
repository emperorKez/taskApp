// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

// @immutable
class TaskState {
  final List<Task> taskList;
  TaskState({List<Task>? taskList
    //  this.taskList = [],
  }) : taskList = taskList ?? [];
 }

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
   TaskLoaded({required super.taskList});
}
class TaskError extends TaskState {
  final String error;
   TaskError({
    this.error = 'Something went wrong',
  });
}
