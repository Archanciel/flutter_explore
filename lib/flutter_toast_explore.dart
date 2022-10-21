// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter  Show Text Tag Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          key: const Key('homePage'), title: 'Flutter Show Text Tag demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode _focusNode = FocusNode();
  GlobalKey _textFieldKey = GlobalKey();
  TextStyle _textFieldStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
  }

  // Code reference for overlay logic from MTECHVIRAL's video
  // https://www.youtube.com/watch?v=KuXKwjv2gTY

  showOverlaidTag(BuildContext context, String newText) async {
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        style: _textFieldStyle,
        text: newText,
      ),
    );
    painter.layout();

    OverlayState overlayState = Overlay.of(context)!;
    OverlayEntry suggestionTagoverlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        // Decides where to place the tag on the screen.
        top: _focusNode.offset.dy + painter.height - 50,
        left: _focusNode.offset.dx + painter.width / 2,

        // Tag code.
        child: const Material(
            elevation: 4.0,
            color: Colors.lightBlueAccent,
            child: Text(
              'Show tag here',
              style: TextStyle(
                fontSize: 20.0,
              ),
            )),
      );
    });
    overlayState.insert(suggestionTagoverlayEntry);

    // Removes the over lay entry from the Overly after 500 milliseconds
    await Future.delayed(Duration(milliseconds: 500));
    suggestionTagoverlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          child: TextField(
            focusNode: _focusNode,
            key: _textFieldKey,
            style: _textFieldStyle,
            onChanged: (String nextText) {
              showOverlaidTag(context, nextText);
            },
          ),
          width: 400.0,
        ),
      ),
    );
  }
}
