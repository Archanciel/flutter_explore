// https://pastebin.com/jKcg71YW

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Context Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, Key key = const Key('hhh')})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController(text: 'Hello World !');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                // intercept all pointer calls. Required, otherwise
                // GestureDetector.onTap:, onDoubleTap:, onLongPress:
                // not applied
                behavior: HitTestBehavior.opaque,
                onDoubleTap: () async {
                  await copyToClipboard(
                      context: context, controller: _controller);
                },
                child: IgnorePointer(
                  // required for onLongPress selection to work
                  // Prevents displaying copy menu after selecting in TextField
                  child: TextField(
                    controller: _controller,
                    readOnly: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> copyToClipboard(
      {required BuildContext context,
      required TextEditingController controller,
      bool extractHHmmFromCopiedStr = false}) async {
    // avoiding selecting the value copied to clipboard !
    // controller.selection = TextSelection(
    //     baseOffset: 0, extentOffset: controller.value.text.length);

    String selectedText = controller.text;

    if (extractHHmmFromCopiedStr) {
      selectedText = selectedText.substring(selectedText.length - 5);
    } else {
      // useful in case copying Calculate Sleep Duration screen percent values
      selectedText = selectedText.replaceAll(' %', '');

      if (selectedText.contains('=')) {
        // the case if copyToClipboard() was applied on result
        // TextField of the TimeCalculator screen and that the field
        // contained a string like 01:10:05 = 40:05. In this situation,
        // 40.05 is copied to clipboard !
        List<String> selectedTextLst = selectedText.split(' = ');
        selectedText = selectedTextLst.last;
      }
    }

    await Clipboard.setData(ClipboardData(text: selectedText));

    final CustomSnackBar snackBar =
        CustomSnackBar(message: '$selectedText copied to clipboard');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({required String message})
      : super(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          backgroundColor: Colors.blue,
          duration: const Duration(milliseconds: 2000),
        );
}
