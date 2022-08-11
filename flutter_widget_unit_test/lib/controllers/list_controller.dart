import 'package:flutter_widget_unit_test/models/todo.dart';
import 'package:flutter_widget_unit_test/services/database.dart';

class ListController {
  final Database database;
  List<TodoModel> todoList = [];

  ListController({required this.database});

  void addTodo(TodoModel todo) {
    todoList.add(todo);
  }

  void checkboxSelected(bool newValue, int index) {
    todoList[index].done = newValue;
  }

  void clear() {
    todoList.clear();
  }

  Future<void> loadFromDatabase() async {
    todoList.add(await database.loadDatabase());
  }
}
