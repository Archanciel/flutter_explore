import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Popup Menu on AppBar"),
          backgroundColor: Colors.blue,
          elevation: 0,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Three"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Four"),
                ),
                const PopupMenuItem<int>(
                  value: 5,
                  child: Text("Five"),
                ),
                const PopupMenuItem<int>(
                  value: 6,
                  child: Text("Six"),
                ),
                const PopupMenuItem<int>(
                  value: 7,
                  child: Text("Seven"),
                ),
              ];
            }, onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    print("My account menu is selected.");
                    break;
                  }
                case 1:
                  {
                    print("Settings menu is selected.");
                    break;
                  }
                case 2:
                  {
                    print("Logout menu is selected.");
                    break;
                  }
                case 3:
                  {
                    print("3 is selected.");
                    break;
                  }
                case 4:
                  {
                    print("4 is selected.");
                    break;
                  }
                case 5:
                  {
                    print("5 is selected.");
                    break;
                  }
                case 6:
                  {
                    print("6 is selected.");
                    break;
                  }
                case 7:
                  {
                    print("7 is selected.");
                    break;
                  }
                default:
                  {}
              }
            }),
          ],
        ),
        body: Container());
  }
}
