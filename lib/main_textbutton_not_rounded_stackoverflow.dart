// https://stackoverflow.com/questions/72043195/how-to-define-a-not-rounded-flutter-textbutton

import 'package:flutter/material.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                    shape:
                        const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
