import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ToDoList/enity/group.dart';
import 'package:ToDoList/enity/task.dart';
import 'package:ToDoList/ui/navigation/main_navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<User>> _groupBox;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  User? _group;
  User? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigatinRoutesNames.tasksform, arguments: groupKey);
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTask() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable().addListener(_readTasks);
  }

  void deletTask(int groupIndex) async {
    await _group?.tasks?.deleteFromHive(groupIndex);
    _group?.save();
  }

  void doneTongle(int groupIndex) async {
    final task = group?.tasks?[groupIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    _groupBox = Hive.openBox<User>('user_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _loadGroup();
    _setupListenTask();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
