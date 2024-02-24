part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

class TasksInitialState extends TasksState {
  final List<Task> allTasks;

  TasksInitialState({required this.allTasks});
}

class TasksFilteredState extends TasksState {
  final List<Task> filteredTasks;

  TasksFilteredState({required this.filteredTasks});
}

class TasksEmptyState extends TasksState {}
