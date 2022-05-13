import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Dialog With TextField';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 32),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(52),
              textStyle: TextStyle(fontSize: 24),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.green,
            contentTextStyle: TextStyle(fontSize: 24),
          ),
        ),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController controller;
  String _name = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(_name),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text('Open Dialog'),
                onPressed: () async {
                  final name = await openDialog();
                  if (name == null || name.isEmpty) return;

                  setState(() => this._name = name);

                  final snackBar = SnackBar(content: Text('Your name: $name'));
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
              ),
            ],
          ),
        ),
      );

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Your Name'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter your name'),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: submit,
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }
}