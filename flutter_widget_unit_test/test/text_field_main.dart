import 'package:flutter/material.dart';

void main() {
  TextEditingController controller = TextEditingController(text: 'Hello world');
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            child: TextField(
              controller: controller,
              onTap: () => print('TextField onTap: detected'),
              readOnly: true,
            ),
            onDoubleTap: () => print('GestureDetector onDoubleTap: detected'),
          ),
        ),
      ),
    ),
  );
}
