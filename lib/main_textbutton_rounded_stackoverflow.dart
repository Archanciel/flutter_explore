// https://stackoverflow.com/questions/72043195/how-to-define-a-not-rounded-flutter-textbutton

import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    print('note1.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    print('note2.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    print('note3.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    print('note4.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    print('note5.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    print('note6.wav');
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: const Text(''),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    print('note7.wav');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
