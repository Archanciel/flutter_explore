import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with ScreenMixin {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ScreenMixin.appTitle,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: appTextAndIconColor, // requires with ScreenMixin !
        ),
      ),
      home: FirstScreen(),
    );
  }
}

mixin ScreenMixin {
  /// This mixin class contains UI parameters used by all the Circa
  /// application screens. Since it is not possible to define a
  /// base class for the statefull widgets, using a mixin class
  /// to add those common instance variables to the statefull
  /// widgets solves the problem.
  static const String appTitle = 'Screen Slide Navigation Explore';
  final Color appLabelColor = Colors.yellow.shade300;
  final Color appTextAndIconColor = Colors.white;
  final MaterialStateProperty<Color?> appElevatedButtonBackgroundColor =
      MaterialStateProperty.all(Colors.blue[900]);
  final MaterialStateProperty<RoundedRectangleBorder>
      appElevatedButtonRoundedShape =
      MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)));
  static const FontWeight appTextFontWeight = FontWeight.normal;
  static const double appTextFontSize = 20;
  static const double appDrawerTextFontSize = 18;
  static const double appDrawerWidthProportion = 0.92;
  static const double appDrawerHeaderHeight = 80;
  static const String appDrawerHeaderText = ScreenMixin.appTitle;
  static const FontWeight appDrawerFontWeight = FontWeight.bold;
  static const String firstScreenTitle = 'First Screen';
  static const String secondScreenTitle = 'Second Screen';
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() {
    return _FirstScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class _FirstScreenState extends State<FirstScreen> with ScreenMixin {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: Container(
        width: MediaQuery.of(context).size.width *
            ScreenMixin.appDrawerWidthProportion,
        child: Drawer(
          backgroundColor: Colors.blue[300],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: ScreenMixin.appDrawerHeaderHeight,
                child: DrawerHeader(
                  child: Text(
                    ScreenMixin.appDrawerHeaderText,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: ScreenMixin.appTextFontSize,
                      fontWeight: ScreenMixin.appDrawerFontWeight,
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.keyboard_double_arrow_up,
                ),
                title: const Text(
                  ScreenMixin.secondScreenTitle,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: ScreenMixin.appDrawerTextFontSize,
                    fontWeight: ScreenMixin.appDrawerFontWeight,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SecondScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: appLabelColor,
        title: const Text(ScreenMixin.firstScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget with ScreenMixin {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: Container(
        width: MediaQuery.of(context).size.width *
            ScreenMixin.appDrawerWidthProportion,
        child: Drawer(
          backgroundColor: Colors.blue[300],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: ScreenMixin.appDrawerHeaderHeight,
                child: DrawerHeader(
                  child: Text(
                    ScreenMixin.appDrawerHeaderText,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: ScreenMixin.appTextFontSize,
                      fontWeight: ScreenMixin.appDrawerFontWeight,
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.keyboard_double_arrow_up,
                ),
                title: const Text(
                  ScreenMixin.firstScreenTitle,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: ScreenMixin.appDrawerTextFontSize,
                    fontWeight: ScreenMixin.appDrawerFontWeight,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => FirstScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: appLabelColor,
        title: const Text(ScreenMixin.secondScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
