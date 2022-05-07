import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disabling Button',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1
  bool _isAcceptTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: _isAcceptTermsAndConditions,
                    onChanged: (value) {
                      setState(() {
                        // 2
                        _isAcceptTermsAndConditions = value ?? false;
                      });
                    }),
                Text('I accept the terms and conditions.'),
              ],
            ),
            ElevatedButton(
              // 3
              onPressed: _isAcceptTermsAndConditions
                  ? () {
                      print('Submit');
                    }
                  : null,
              child: Text('Click Me!'),
            ),
          ],
        ),
      ),
    );
  }
}
