import 'package:flutter/material.dart';
import 'package:ToDoList/enity/group.dart';
import 'package:hive/hive.dart';

class GroupFormWidgetModel extends ChangeNotifier {
  var groupName = '';
  String? errorText;

  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    final box = await Hive.openBox<User>('user_box');
    final user = User(name: groupName);
    if (groupName.trim().length <= 3)  {
      errorText = 'Name must be at least 3 characters long';
      notifyListeners();
      return;
    } else {
      await box.add(user);
    }
    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvider extends InheritedNotifier {
  final GroupFormWidgetModel model;
  const GroupFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static GroupFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
        ?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider oldWidget) {
    return false;
  }
}
