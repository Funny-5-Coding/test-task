import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task_model.dart';

/// [AddTaskScreen] class for adding new tasks
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String _selectedCategory = 'Other'; // default category

  final List<String> dropDownMenuItems = ['Work', 'Daily', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 15),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task Title',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task Description',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                items: dropDownMenuItems
                    .map<DropdownMenuItem<String>>(
                        (element) => DropdownMenuItem<String>(
                              value: element,
                              child: Text(element),
                            ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _selectedCategory = value.toString();
                }),
                value: _selectedCategory,
              ),
              ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    category: _selectedCategory,
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
