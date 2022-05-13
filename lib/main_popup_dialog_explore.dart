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
  static final String title = 'Warning Dialog';

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
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text('Open Dialog'),
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
