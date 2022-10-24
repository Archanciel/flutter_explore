// https://pastebin.com/jKcg71YW

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Context Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, Key key = const Key('hhh')})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _textfieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                // intercept all pointer calls
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // required, otherwise, field not focusable
                  FocusScope.of(context).requestFocus(
                    _textfieldFocusNode,
                  );
                  _controller.selection =
                      const TextSelection(baseOffset: 0, extentOffset: 0);
                },
                onLongPress: () {
                  _controller.selection = TextSelection(
                      baseOffset: 0, extentOffset: _controller.text.length);
                },
                child: IgnorePointer( // required for onLongPress selection to work
                  // Prevents displaying copèy menu after selecting in TextField
                  child: TextField(
                    // Required, otherwise, field not focusable due to
                    // IgnorePointer wrapping
                    focusNode: _textfieldFocusNode,
                    controller: _controller,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
