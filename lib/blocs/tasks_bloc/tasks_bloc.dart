import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import 'package:todo_test_task/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

/**
 * For saving and loading data from storage
 * uses [HydratedBloc] package 
 */

/// [TasksBloc] class for handling and saving tasks data
/// Returns [TasksState] with [TasksInitialState], [TasksEmptyState]
/// or [TasksFilteredState].

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  List<Task> tasksList;

  TasksBloc({
    required this.tasksList,
  }) : super(TasksEmptyState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<FilterTasks>(_onFilterTasks);
  }

  _onAddTask(AddTask event, emit) {
    tasksList.add(event.task);

    if (tasksList.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksInitialState(allTasks: tasksList));
    }
  }

  void _onUpdateTask(UpdateTask event, emit) {
    event.task.isCompleted = !event.task.isCompleted;
    emit(TasksInitialState(allTasks: tasksList));
  }

  void _onDeleteTask(DeleteTask event, emit) {
    tasksList.remove(event.task);

    if (tasksList.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksInitialState(allTasks: tasksList));
    }
  }

  void _onFilterTasks(FilterTasks event, emit) {
    List<Task> filteredTasksList = event.category == 'None'
        ? tasksList
            .where((element) => element.isCompleted == event.cheker)
            .toList()
        : tasksList
            .where((element) =>
                (element.category == event.category) &&
                (element.isCompleted == event.cheker))
            .toList();

    if (filteredTasksList.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksFilteredState(filteredTasks: filteredTasksList));
    }
  }

  @override
  TasksState fromJson(Map<String, dynamic> json) {
    tasksList = List<Task>.from(
      json['tasksList']?.map((x) => Task.fromMap(x)),
    );
    if (tasksList.isEmpty) {
      return TasksEmptyState();
    }

    return TasksInitialState(allTasks: tasksList);
  }

  @override
  Map<String, dynamic> toJson(TasksState state) {
    return {'tasksList': tasksList.map((task) => task.toMap()).toList()};
  }
}
