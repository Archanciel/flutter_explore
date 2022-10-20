// posted on StackOverflow: https://stackoverflow.com/questions/72269478/how-to-enable-copy-paste-on-flutter-textfield-widget/72269479#72269479

// ignore_for_file: avoid_print

import 'dart:math';

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
  final TextEditingController _controller = TextEditingController(
      text:
          'Sleep 12-04-2022 12:16, 15:40, 3:11\nWake 02-12-2022 3:56, 05:40, 0:11');

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
          maxLines: null, // must be set, otherwise multi lines
          //                 not displayed
          readOnly: true,
          controller: _controller,
          onTap: () {
            int tapStringPosition = _controller.selection.start; // equal to
            //                                   _controller.selection.end !
            String hhmmStr = extractHHmmAtPositionSimplified(
              dataStr: _controller.text,
              pos: tapStringPosition,
            );
            int hhmmStrStartIdx = _controller.text.indexOf(hhmmStr);
            int hhmmStrEndIdx = hhmmStrStartIdx + hhmmStr.length;
            _controller.selection = TextSelection(
                baseOffset: hhmmStrStartIdx, extentOffset: hhmmStrEndIdx);
          },
        ),
      ),
    );
  }

  String extractHHmmAtPositionSimplified({
    required String dataStr,
    required int pos,
  }) {
    int dataStrLength = dataStr.length;
    int endIdx = 0;
    int endIdxLineEnd =
        dataStr.substring(0, dataStrLength).indexOf(RegExp(r'[\n]'));
    if (pos <= endIdxLineEnd) {
      // the case if clicking on first line
      int endIdxComma =
          dataStr.substring(pos, dataStrLength).indexOf(RegExp(r'[,]')) + pos;
      endIdx = (endIdxLineEnd < endIdxComma) ? endIdxLineEnd : endIdxComma;
    } else {
      // the case if clicking on second line
      int endIdxComma =
          dataStr.substring(pos, dataStrLength).indexOf(RegExp(r'[,]')) + pos;
      endIdx = (endIdxComma <= dataStrLength - 5) ? endIdxComma : dataStrLength;
    }

    int startIdx = dataStr.substring(0, endIdx).lastIndexOf(' ') + 1;

    String hhMmStr = dataStr.substring(startIdx, endIdx);

    return hhMmStr;
  }

  String extractHHmmAtPosition({
    required String dataStr,
    required int pos,
  }) {
    if (pos > dataStr.length) {
      return '';
    }

    int newLineCharIdx = dataStr.lastIndexOf('\n');
    int leftIdx;

    if (pos > newLineCharIdx) {
      // the case if clicking on second line
      leftIdx = dataStr.substring(newLineCharIdx + 1, pos).lastIndexOf(' ') +
          newLineCharIdx;
    } else {
      leftIdx = dataStr.substring(0, pos).lastIndexOf(' ');
    }

    String extractedHHmmStr;

    if (leftIdx == -1) {
      // the case if selStartPosition is before the first space position
      leftIdx = 0;
    }

    int rightIdx = dataStr.indexOf(',', pos);

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
