import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';

/// [TasksFilters] class for filtering tasks
/// by category ['Work', 'Daily', 'Other'] and status ['Checked', 'Unchecked']
class TasksFilters extends StatefulWidget {
  const TasksFilters({super.key});

  @override
  State<TasksFilters> createState() => _TasksFiltersState();
}

class _TasksFiltersState extends State<TasksFilters> {
  List<String> categories = ['Work', 'Daily', 'Other', 'None'];
  List<String> checkers = ['Checked', 'Unchecked'];

  String _userCategory = 'None'; // default category
  String _userCheker = 'Unchecked'; // default cheker

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            const Text(
              'Filter by Category: ',
              style: TextStyle(fontSize: 15),
            ),
            DropdownButton(
              items: categories
                  .map<DropdownMenuItem<String>>((element) => DropdownMenuItem(
                        value: element,
                        child: Text(element),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _userCategory = value.toString();
                });
                context.read<TasksBloc>().add(FilterTasks(
                      category: _userCategory,
                      cheker: _userCheker == 'Checked' ? true : false,
                    ));
              },
              value: _userCategory,
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Filter by Status: ',
              style: TextStyle(fontSize: 15),
            ),
            DropdownButton(
              items: checkers
                  .map<DropdownMenuItem<String>>((element) => DropdownMenuItem(
                        value: element,
                        child: Text(element),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _userCheker = value.toString();
                  context.read<TasksBloc>().add(FilterTasks(
                        category: _userCategory,
                        cheker: _userCheker == 'Checked' ? true : false,
                      ));
                });
              },
              value: _userCheker,
            ),
          ],
        ),
      ],
    );
  }
}
