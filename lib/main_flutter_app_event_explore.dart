// the Johannes Milke app video: https://www.youtube.com/watch?v=JyapvlrmM24

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await TextPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Detect Background & App Closed';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  late TextEditingController _controller;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final text = TextPreferences.getText();
    _controller = TextEditingController(text: text);
    print('initState executed');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      TextPreferences.setText(_controller.text);
    }

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(child: buildTextField()),
        ),
      );

  Widget buildTextField() => TextField(
        controller: _controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Text',
          hintText: 'Enter Text',
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      );
}

class TextPreferences {
  static late SharedPreferences _preferences;

  static const _keyText = 'text';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setText(String text) async =>
      await _preferences.setString(_keyText, text);

  static String getText() => _preferences.getString(_keyText) ?? '';
}
