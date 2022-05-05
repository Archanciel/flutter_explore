import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stack align explore',
      theme: ThemeData.dark(),
      home: MyStatefulApp(),
    );
  }
}

class MyStatefulApp extends StatefulWidget {
  MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => _MyStatefulAppState();
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  String _status = 'Wake up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
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
                Text(
                    'Flutter stack align explore much better than\nFlutter Stack Align explore'),
                Text('Two'),
                Text('Three'),
                Text('Four'),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () => print('aaa'),
                    child: Text(
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
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
                child: Text('Reset')),
          ),
        ],
      ),
    );
  }
}
