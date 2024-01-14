import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter spacer explore',
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
        'Flutter spacer explore',
      )),
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text('One'),
              Text('Two'),
              Text('Three'),
              Text('Four'),
            ],),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text(_status),
                const Spacer(),
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
                    child: const Text('Reset')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
