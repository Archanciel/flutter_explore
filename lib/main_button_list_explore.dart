// https://stackoverflow.com/questions/72043195/how-to-define-a-not-rounded-flutter-textbutton

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: XylophoneApp(),
    );
  }
}

class XylophoneApp extends StatefulWidget {
  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(''),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: _showPopupMenu,
            ),
          ],
        ),
      ),
    );
  }

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(0.0, 455.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        const PopupMenuItem<String>(child: Text('menu option 1'), value: '1'),
        const PopupMenuItem<String>(child: Text('menu option 2'), value: '2'),
        const PopupMenuItem<String>(child: Text('menu option 3'), value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      print('itemSelected $itemSelected');

      if (itemSelected == "1") {
        print('itemSelected ONE');
      } else if (itemSelected == "2") {
        print('itemSelected TWO');
      } else {
        print('itemSelected THREE');
      }
    });
  }
}
