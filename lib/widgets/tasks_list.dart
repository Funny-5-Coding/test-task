import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task_model.dart';

/// [TasksList] builds a group list of tasks from a list of tasks
/// and allows to update or delete them
/// for group use [GroupedListView] widget
class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GroupedListView(
        useStickyGroupSeparators: true,
        elements: taskList,
        groupBy: (element) => element.category,
        itemComparator: (element1, element2) =>
            element1.title.compareTo(element2.title),
        groupComparator: (value1, value2) => value1.compareTo(value2),
        groupSeparatorBuilder: (value) => Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.grey.shade200,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        itemBuilder: (context, element) => ListTile(
          title: Text(element.title),
          subtitle: Text(element.description),
          trailing: Checkbox(
            value: element.isCompleted,
            onChanged: (value) {
              context.read<TasksBloc>().add(UpdateTask(task: element));
            },
          ),
          onLongPress: () =>
              context.read<TasksBloc>().add(DeleteTask(task: element)),
        ),
      ),
    );
  }
}
