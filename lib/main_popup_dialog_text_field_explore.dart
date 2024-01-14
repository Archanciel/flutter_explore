import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Dialog With TextField';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 32),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              textStyle: const TextStyle(fontSize: 24),
            ),
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.green,
            contentTextStyle: TextStyle(fontSize: 24),
          ),
        ),
        home: const MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
          title: const Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
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
                child: const Text('Open Dialog'),
                onPressed: () async {
                  final name = await openDialog();
                  if (name == null || name.isEmpty) return;

                  setState(() => _name = name);

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
          title: const Text('Your Name'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter your name'),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              child: const Text('SUBMIT'),
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