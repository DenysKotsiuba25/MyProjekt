import 'package:ToDoList/enity/task.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList<Task>? tasks;

  User({required this.name});

  void addTask(Box<Task> box, Task task) {
    tasks ??= HiveList(box);
    tasks?.add(task);
    save();
  }
}
