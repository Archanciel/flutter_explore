// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter  Show Text Tag Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
          key: Key('homePage'), title: 'Flutter Show Text Tag demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _textFieldKey = GlobalKey();
  final TextStyle _textFieldStyle = const TextStyle(fontSize: 20);

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textFieldController = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: const Text("Custom Toast"),
    );

    // Custom Toast Position
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: _focusNode.offset.dy - 55,
          left: _textFieldController.selection.start.toDouble() * 2,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              focusNode: _focusNode,
              controller: _textFieldController,
              key: _textFieldKey,
              style: _textFieldStyle,
            ),
            const SizedBox(
              height: 250.0,
            ),
            ElevatedButton(
              onPressed:() {
                _showToast();
              }, 
              child: const Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}
