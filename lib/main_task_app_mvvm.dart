import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// task.dart

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

// task_view_model.dart

// import 'package:flutter/foundation.dart';
// import 'task.dart';

class TaskListViewModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(title: title));
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }
}

// main.dart

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskListViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListView(),
    );
  }
}

// task_list_view.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'task_view_model.dart';

class TaskListView extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: Consumer<TaskListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => viewModel.deleteTask(index),
                ),
                onTap: () => viewModel.toggleTaskCompletion(index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Task'),
              content: TextField(
                controller: _taskController,
                decoration: InputDecoration(hintText: 'Enter task title'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Provider.of<TaskListViewModel>(context, listen: false)
                        .addTask(_taskController.text);
                    _taskController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    _taskController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
