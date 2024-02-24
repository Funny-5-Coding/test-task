import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_test_task/models/task_model.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../blocs/weather_bloc/weather_bloc.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/tasks_filters.dart';
import '../widgets/tasks_list.dart';
import '../widgets/weather_widget.dart';

/// [MainScreen] class for displaying tasks.
/// Allows to filter them
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  void _showWeather(BuildContext context) {
    context.read<WeatherBloc>().add(GetWeather());
    showModalBottomSheet(
      context: context,
      builder: (context) => const WeatherWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks App')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TasksFilters(),
          const SizedBox(height: 10),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksEmptyState) {
                return const Center(
                  child: Text('No tasks found!'),
                );
              }
              if (state is TasksInitialState) {
                List<Task> taskList = state.allTasks;
                return TasksList(taskList: taskList);
              }
              if (state is TasksFilteredState) {
                List<Task> filteredTaskList = state.filteredTasks;
                return TasksList(taskList: filteredTaskList);
              } else {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showWeather(context),
            tooltip: 'Weather',
            child: const Icon(Icons.sunny),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
