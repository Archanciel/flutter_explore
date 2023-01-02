import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiline TextField explore',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Multiline TextField explore',
      )),
      body: GestureDetector(
        // enables that when clicking above or below a
        // TextField, the keyboard is hidden. Otherwise,
        // the keyboard remains open !
        onTap: () {
          // call this method here to hide soft keyboard
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Multiline TextField'),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 4,
                onSubmitted: (value) {
                  print('\n******** TextField value: $value *******\n');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
