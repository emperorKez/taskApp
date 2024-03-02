// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
class TaskEvent {}

class FetchTask extends TaskEvent{}

class CreateTask extends TaskEvent{
  final Task task;
  CreateTask({
    required this.task,
  });
}
