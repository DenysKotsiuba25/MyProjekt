import 'package:flutter/material.dart';
import 'package:ToDoList/ui/widgets/task/tasks_widget_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TasksWidget extends StatefulWidget {
  final int groupKey;
  const TasksWidget({Key? key, 
  required this.groupKey}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksWidgetModel(groupKey:  widget.groupKey);
  }

 
  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model,
      child: const TasksWidgetBody(),
    );
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Zadania';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexInList: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone ? Icons.check_box : Icons.check_box_outline_blank;
    final style = task.isDone
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
          )
        : null;

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deletTask(indexInList),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text,
            style: style,
          ),
          trailing: Icon(icon),
          onTap: () => model.doneTongle(indexInList),
        ),
      ),
    );
  }
}
