import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter spacer explore',
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
        'Flutter spacer explore',
      )),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const Text('One'),
              const Text('Two'),
              const Text('Three'),
              const Text('Four'),
            ],),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(_status),
                Spacer(),
                TextButton(
                    style: const ButtonStyle(
                        visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity)),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
