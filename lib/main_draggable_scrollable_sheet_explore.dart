import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable scrollable sheet explore',
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
        'Draggable scrollable sheet explore',
      )),
      body: DraggableScrollableSheet(
        initialChildSize: 1.0, // necessary to use full screen surface
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView( // necessary for scrolling to work
            child: GestureDetector(
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
                  children: const [
                    Text('One'),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ),
                    Text('Two'),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ),
                    Text('Three'),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ),
                    Text('Four'),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ),
                    Text('Five'),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
