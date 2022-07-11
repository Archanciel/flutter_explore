import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Popup Menu on AppBar"),
          backgroundColor: Colors.blue,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                print("My account menu is selected.");
              } else if (value == 1) {
                print("Settings menu is selected.");
              } else if (value == 2) {
                print("Logout menu is selected.");
              }
            }),
          ],
        ),
        body: Container());
  }
}
