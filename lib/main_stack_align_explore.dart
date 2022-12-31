import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stack align explore',
      theme: ThemeData.dark(),
      home: const MyStatefulApp(),
    );
  }
}

class MyStatefulApp extends StatefulWidget {
  const MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => _MyStatefulAppState();
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  String _status = 'Wake up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Flutter stack align explore',
      )),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'Flutter stack align explore much better than\nFlutter Stack Align explore'),
                const Text('Two'),
                const Text('Three'),
                const Text('Four'),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () => print('aaa'),
                    child: const Text(
                      'Button',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                Container(
                  child: Text(_status),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                style: const ButtonStyle(
                  visualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity),
                ),
                onPressed: () {
                  setState(() {
                    if (_status == 'Wake up') {
                      _status = 'Sleep';
                    } else {
                      _status = 'Wake up';
                    }
                  });
                },
                child: const Text('Reset')),
          ),
        ],
      ),
    );
  }
}
