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
  static const String title = 'Warning Dialog';

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
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Dialog'),
                onPressed: () {
                  openWarningDialog(context,
                      'You entered an incorrectly formated time. Please retry !');
                },
              ),
            ],
          ),
        ),
      );
}

void openWarningDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('WARNING'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
