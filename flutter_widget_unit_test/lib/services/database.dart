import 'package:flutter_widget_unit_test/models/todo.dart';

class Database {
  Future<TodoModel> loadDatabase() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return TodoModel("From Database", true);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
