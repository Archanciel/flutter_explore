import 'package:flutter/material.dart';

// Define a custom AppBar
class MyAppBar extends AppBar implements PreferredSizeWidget {
  final double height;

  MyAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      title: const Text(
        'My AppBar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// Define a custom menu item
class MyMenuItem extends StatelessWidget {
  final String title;
  final Color color;

  const MyMenuItem({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

// Use custom appbar and menu item
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(height: 80.0),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyMenuItem(title: 'Home', color: Colors.blue),
            MyMenuItem(title: 'About', color: Colors.green),
            MyMenuItem(title: 'Settings', color: Colors.red),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyHomePage());
}
