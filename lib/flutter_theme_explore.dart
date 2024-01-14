import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';
    // final ThemeData baseThemeData = ThemeData.dark();
    //ThemeData baseThemeData = Theme.of(context);
    //ThemeData baseThemeData = ThemeData.light();
    ThemeData baseThemeData = ThemeData.dark();

    return MaterialApp(
      title: appName,
      // theme: ThemeData(
      //   accentColor: Colors.indigo, // DEPRECATED
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.lightBlue[800],

      //   // Define the default font family.
      //   fontFamily: 'Lato',

      //   // Define the default `TextTheme`. Use this to specify the default
      //   // text styling for headlines, titles, bodies of text, and more.
      //   textTheme: const TextTheme(
      //     headline1: TextStyle(
      //       fontSize: 72.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     headline6: TextStyle(
      //       fontFamily: 'Georgia',
      //       fontSize: 36.0,
      //       fontStyle: FontStyle.italic,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.red,
      //     ),
      //     bodyText2: TextStyle(
      //       fontSize: 22.0,
      //       fontFamily: 'Lato',
      //       color: Colors.yellow,
      //     ),
      //   ),
      // ),
      
      // SOLVING THE DEPRECATED USE OF accentColor
      theme: baseThemeData.copyWith(
        //accentColor: Colors.indigo, // DEPRECATED
        colorScheme:
            baseThemeData.colorScheme.copyWith(secondary: Colors.indigo),
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        // NOT POSSIBLE WITH copyWith !

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          bodyMedium: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Lato',
            color: Colors.yellow,
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
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Text with a background and foreground color headline6',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Text bodyText2',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Text(
                'Text default',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.yellow),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
