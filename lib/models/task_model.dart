// lib/models/task_model.dart

enum Priority { Low, Medium, High }

class Task {
  String name;
  bool isCompleted;
  Priority priority;
  DateTime createdAt;

  Task({
    required this.name,
    this.isCompleted = false,
    this.priority = Priority.Low,
  }) : createdAt = DateTime.now(); // Set createdAt to the current time
}
