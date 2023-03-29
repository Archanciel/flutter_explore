import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskController {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(title: title));
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].toggleDone();
  }
}





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

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TextEditingController _taskTextController = TextEditingController();
  final TaskController _taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskTextController,
              onSubmitted: (value) => () {
                setState(() {
                  _taskController.addTask(_taskTextController.text);
                });
                _taskTextController.clear();
              }(),
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
                      decoration:
                          task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _taskController.deleteTask(index);
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _taskController.toggleTaskCompletion(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _taskController.addTask(_taskTextController.text);
          });
          _taskTextController.clear();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
