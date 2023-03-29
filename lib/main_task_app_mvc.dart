import 'package:flutter/material.dart';

// task_model.dart

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskList {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(title: title));
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  void toggleTask(int index) {
    _tasks[index].toggleDone();
  }
}

// task_controller.dart

// import 'task_model.dart';

class TaskController {
  final TaskList _taskList = TaskList();

  List<Task> get tasks => _taskList.tasks;

  void addTask(String title) {
    _taskList.addTask(title);
  }

  void deleteTask(int index) {
    _taskList.deleteTask(index);
  }

  void toggleTask(int index) {
    _taskList.toggleTask(index);
  }
}

// main.dart

// import 'package:flutter/material.dart';
// import 'task_controller.dart';
// import task_list_view.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListView(),
    );
  }
}

// task_list_view.dart

// import 'package:flutter/material.dart';
// import 'task_view_model.dart';
// import task_controller.dart

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TextEditingController _controller = TextEditingController();
  final TaskController _taskController = TaskController();

  void _addTask() {
    setState(() {
      _taskController.addTask(_controller.text);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (value) => _addTask(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _taskController.tasks.length,
              itemBuilder: (context, index) {
                final task = _taskController.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _taskController.deleteTask(index);
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _taskController.toggleTask(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
