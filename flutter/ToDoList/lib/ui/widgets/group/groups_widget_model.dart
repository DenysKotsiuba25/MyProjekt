import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ToDoList/enity/group.dart';
import 'package:ToDoList/enity/task.dart';
import 'package:ToDoList/ui/navigation/main_navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroupsWidgetModel extends ChangeNotifier {
  var _groups = <User>[];

  List<User> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigatinRoutesNames.groupsForm);
  }

  void showTasks(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    final box = await Hive.openBox<User>('user_box');
    final groupKey = box.keyAt(groupIndex) as int;

    unawaited(
        Navigator.of(context).pushNamed(MainNavigatinRoutesNames.tasks, arguments: groupKey));
  }

  void deletGroup(int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    final box = await Hive.openBox<User>('user_box');
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  void _readUserFromHive(Box<User> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }

    final box = await Hive.openBox<User>('user_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('tasks_box');
    _readUserFromHive(box);
    box.listenable().addListener(() => _readUserFromHive(box));
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier {
  final GroupsWidgetModel model;
  const GroupsWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static GroupsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()
        ?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }
}
