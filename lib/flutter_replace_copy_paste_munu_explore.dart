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
  const MyHomePage({required this.title, Key key = const Key('hhh')}) : super(key: key);

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
                  FocusScope.of(context).requestFocus(_textfieldFocusNode);
                },
                onLongPress: () {
                  showMenu(
                    context: context,
                    // TODO: Position dynamically based on cursor or textfield
                    position: const RelativeRect.fromLTRB(0.0, 400.0, 300.0, 0.0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: <Widget>[
                            const PopupMenuItem(
                              child: Text(
                                "Paste",
                              ),
                            ),
                            const PopupMenuItem(
                              child: Text("Paste All",
                                  style: TextStyle(color: Colors.blue)),
                            ),
                            const PopupMenuItem(
                              // child: Icon(Icons.more_vert),
                              child: Icon(Icons.play_circle_filled),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
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
