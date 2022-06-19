import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatelessWidget(),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // set up the buttons
        Widget cancelButton = TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context, 'Cancel'),
        );
        Widget continueButton = TextButton(
          child: Text("Ok"),
          onPressed: () => Navigator.pop(context, 'Ok'),
        );
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              cancelButton,
              continueButton,
            ],
          ),
        ).then((value) => print(value));
      },
      child: const Text('Show Dialog'),
    );
  }
}
