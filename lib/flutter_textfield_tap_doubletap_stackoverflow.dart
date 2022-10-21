// posted on StackOverflow: https://stackoverflow.com/questions/72269478/how-to-enable-copy-paste-on-flutter-textfield-widget/72269479#72269479

// ignore_for_file: avoid_print

import 'dart:math';

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
  final TextEditingController _controller = TextEditingController(
      text:
          'Sleep 12-04-2022 12:16, 15:40, 3:11\nWake 02-12-2022 3:56, 05:40, 0:11');
  final TextEditingController _positionController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField onTap and onDoubleTap"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GestureDetector(
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                maxLines: null, // must be set, otherwise multi lines
                //                 not displayed
                readOnly: true,
                controller: _controller,
                onTap: () {
                  int tapStringPosition =
                      _controller.selection.start; // equal to
                  //                                   _controller.selection.end !
                  _positionController.text = tapStringPosition.toString();
                },
              ),
              onDoubleTap: () {
                // prevents TextField selection
              },
            ),
            TextField(
              controller: _positionController,
              style: const TextStyle(
                fontSize: 20,
              ),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
