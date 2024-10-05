// lib/screens/task_list_screen.dart

import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_item.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  Priority _selectedPriority = Priority.Low;

  void _addTask() {
    if (_taskController.text.isEmpty) return;

    setState(() {
      _tasks.add(Task(
        name: _taskController.text,
        priority: _selectedPriority,
      ));
      _taskController.clear();
    });
    _sortTasks();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (b.priority.index != a.priority.index) {
        return b.priority.index.compareTo(a.priority.index);
      } else {
        return a.createdAt.compareTo(b.createdAt); // Sort by creation time for same priority
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter task name',
                    ),
                  ),
                ),
                DropdownButton<Priority>(
                  value: _selectedPriority,
                  onChanged: (Priority? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                  items: Priority.values.map((Priority priority) {
                    return DropdownMenuItem<Priority>(
                      value: priority,
                      child: Text(priority.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: _tasks[index],
                  onCheckboxChanged: (value) => _toggleTaskCompletion(index),
                  onDelete: () => _deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
