// posted on StackOverflow: https://stackoverflow.com/questions/72269478/how-to-enable-copy-paste-on-flutter-textfield-widget/72269479#72269479

// ignore_for_file: avoid_print

import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textFieldOneController =
      TextEditingController(text: '12-04-2022 13:56, 15:40, 23:11');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField onTap and onDoubleTap"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: TextField(
          style: const TextStyle(
            fontSize: 20,
          ),
          readOnly: true,
          // enabling select all/cut/copy/paste
          enableInteractiveSelection: true,
          controller: _textFieldOneController,
          onTap: () => print(
              'on tap or on double tap: ${_textFieldOneController.selection.start}, ${_textFieldOneController.selection.end}'),
        ),
      ),
    );
  }
}
