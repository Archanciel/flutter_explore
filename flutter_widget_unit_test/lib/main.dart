import 'package:flutter/material.dart';
import 'package:flutter_widget_unit_test/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.dark(),
    );
  }
}
