part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class AddTask extends TasksEvent {
  final Task task;

  AddTask({required this.task});
}

class UpdateTask extends TasksEvent {
  final Task task;

  UpdateTask({required this.task});
}

class DeleteTask extends TasksEvent {
  final Task task;

  DeleteTask({required this.task});
}

class FilterTasks extends TasksEvent {
  final String category;
  final bool cheker;

  FilterTasks({
    required this.category,
    required this.cheker,
  });
}
