// https://pastebin.com/jKcg71YW

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  FocusScope.of(context).requestFocus(
                    _textfieldFocusNode,
                  );
                  _controller.selection =
                      const TextSelection(baseOffset: 0, extentOffset: 0);
                  // setState(() {
                  // });
                },
                onLongPress: () {
                  _controller.selection = TextSelection(
                      baseOffset: 0, extentOffset: _controller.text.length);
                  // setState(() {

                  // });
                },
                child: IgnorePointer(
                  // Prevent the menu due to tap on the textfield (so as to show the menu under GestureDetector)
                  child: TextField(
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
