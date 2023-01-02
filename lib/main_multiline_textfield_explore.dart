// How to enter a new line in a multiline Flutter TextField whose textinputaction is textinputaction.done ?
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter TextField Multiple Lines'),
        ),
        body: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late TextEditingController _controllerEnter;
  late TextEditingController _controllerDone;

  @override
  void initState() {
    super.initState();
    _controllerEnter = TextEditingController();
    _controllerDone = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEnter.dispose();
    _controllerDone.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Multiline TextField Enter',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  style: const TextStyle(fontSize: 20),
                  maxLines: 3,
                  controller: _controllerEnter,
                  onSubmitted: (String value) {
                    // method never called !
                    debugPrint('\n*** onSubmitted: $value ***\n');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Multiline TextField Done',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  // How can Enter be used to add a new line to the TextField ?
                  style: const TextStyle(fontSize: 20),
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _controllerDone,
                  onSubmitted: (String value) {
                    debugPrint('\n*** onSubmitted: $value ***\n');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
