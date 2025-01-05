import 'package:ToDoList/enity/group.dart';
import 'package:ToDoList/enity/task.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int groupKey;
  var _taskText = '';
  

  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value) {
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('task_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<User>('user_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  static TaskFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    return false;
  }
}
