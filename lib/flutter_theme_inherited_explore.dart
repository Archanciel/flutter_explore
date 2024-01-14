import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
        ),
      ),
      home: const MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: _createThemeData(context),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  ThemeData _createThemeData(BuildContext context) {
    final Random randomGenerator = Random();

    bool randomBool = randomGenerator.nextBool();

    if (randomBool) {
      return Theme.of(context).copyWith(
        splashColor: Colors.yellow,
      );
    } else {
      return ThemeData(
        splashColor: Colors.red,
      );
    }
  }
}
