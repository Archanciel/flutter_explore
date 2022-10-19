// posted on StackOverflow: https://stackoverflow.com/questions/72269478/how-to-enable-copy-paste-on-flutter-textfield-widget/72269479#72269479

// ignore_for_file: avoid_print

import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textFieldOneController =
      TextEditingController(text: '12-04-2022 13:56, 15:40, 23:11');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField onTap and onDoubleTap"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: TextField(
          style: const TextStyle(
            fontSize: 20,
          ),
          readOnly: true,
          // enabling select all/cut/copy/paste
          enableInteractiveSelection: true,
          controller: _textFieldOneController,
          onTap: () {
            int tapStringPosition = _textFieldOneController.selection.start;
            int end2 = _textFieldOneController.selection.end;
            print('on tap or on double tap: $tapStringPosition, $end2');
            String hhmmStr = extractHHmmAtPosition(
                dataStr: _textFieldOneController.text,
                selStartPosition: tapStringPosition,
                selEndPosition: tapStringPosition);
            print(hhmmStr);
            int hhmmStrStartIdx = _textFieldOneController.text.indexOf(hhmmStr);
            int hhmmStrEndIdx = hhmmStrStartIdx + hhmmStr.length;
            _textFieldOneController.selection = TextSelection(
                baseOffset: hhmmStrStartIdx,
                extentOffset: hhmmStrEndIdx);
          },
        ),
      ),
    );
  }

  String extractHHmmAtPosition({
    required String dataStr,
    required int selStartPosition,
    required int selEndPosition,
  }) {
    if (selStartPosition > dataStr.length) {
      return '';
    }

    if (dataStr.substring(selStartPosition - 1, selStartPosition) == '\n') {
      // the case if 'Wake' is selected, which is after \n !
      selStartPosition = selEndPosition + 1;
    }

    String extractedHHmmStr;

    int leftIdx = dataStr.substring(0, selStartPosition).lastIndexOf(' ');

    if (leftIdx == -1) {
      // the case if the position is on the last HH:mm value
      leftIdx = 0;
    }

    int rightIdx = dataStr.indexOf(',', selStartPosition);

    if (rightIdx == -1) {
      // the case if the position is on the last HH:mm value
      rightIdx = dataStr.lastIndexOf(RegExp(r'\d')) + 1;
    }

    extractedHHmmStr = dataStr.substring(leftIdx, rightIdx);

    if (extractedHHmmStr.contains(RegExp(r'\D'))) {
      RegExpMatch? match = RegExp(r'\d+:\d+').firstMatch(extractedHHmmStr);

      if (match != null) {
        extractedHHmmStr = match.group(0) ?? '';
      }
    }

    return extractedHHmmStr;
  }
}
