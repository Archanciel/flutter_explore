// posted on StackOverflow: https://stackoverflow.com/questions/72269478/how-to-enable-copy-paste-on-flutter-textfield-widget/72269479#72269479

import "package:flutter/material.dart";

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _textFieldOneController =
      TextEditingController(text: '15-05-2022 13:25');
  final TextEditingController _textFieldTwoController =
      TextEditingController(text: '16-05-2022 23:25');

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text("TextField Select All/Cut/Copy/Paste"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            // enabling select all/cut/copy/paste
            enableInteractiveSelection: true,
            controller: _textFieldOneController,
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            // enabling select all/cut/copy/paste
            enableInteractiveSelection: true,
            controller: _textFieldTwoController,
          ),
        ],
      ),
    );
  }
}
