import 'package:flutter/material.dart';
import 'package:ToDoList/ui/widgets/group/groups_widget.dart';
import 'package:ToDoList/ui/widgets/group_form/group_form_widget.dart';
import 'package:ToDoList/ui/widgets/task/tasks_widget.dart';
import 'package:ToDoList/ui/widgets/task_form/task_form_widget.dart';

abstract class MainNavigatinRoutesNames {
  static const groups = '/';
  static const groupsForm = '/groupsForm';
  static const tasks = 'tasks';
  static const tasksform = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigatinRoutesNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigatinRoutesNames.groups: (context) => const GroupsWidget(),
    MainNavigatinRoutesNames.groupsForm: (context) => const GroupFormWidget(),
   };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigatinRoutesNames.tasks:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TasksWidget(groupKey: groupKey)
        );
      case MainNavigatinRoutesNames.tasksform:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TaskFormWidget(groupKey: groupKey),
          );
      default:
        const widget = Text("Navigation Error!!!");
        return MaterialPageRoute(builder: (context) => widget);
      }
  }
}
