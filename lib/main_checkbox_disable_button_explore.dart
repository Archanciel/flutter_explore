import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checkbox problem',
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Checkbox problem'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.blue,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TwoButtonsWidget(),
          ],
        ),
      ),
    );
  }
}

/// TwoButtonsWidget remains stateful only for the reason that it
/// can so improve performance with avoiding rebuilding it each
/// time its including widget is rebuilt !
class TwoButtonsWidget extends StatefulWidget {
  const TwoButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TwoButtonsWidget> createState() => _TwoButtonsWidgetState();
}

class _TwoButtonsWidgetState extends State<TwoButtonsWidget> {
  Widget? _widgetBody;

  bool _isCheckBoxSelected = false;

  @override
  Widget build(BuildContext context) {
    // if (_widgetBody != null) {
    //   // Since the TwoButtonsWidget layout is not modified
    //   // after it has been built, avoiding rebuilding it
    //   // each time its including widget is rebuilt improves
    //   // app performance. This is not possible if the widget
    //   // is stateless !
    //   return _widgetBody!;
    // } WARNING: THIS MAKES USING CHECKBOX IMPOSSIBLE !
    //
    // After adding a checkbox to the two buttons widget,
    // this optimization prevented the checkbox to be usable
    // since the changed checkbox state was not displayed due
    // to the build method to be exited !

    _widgetBody = Row(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white70,
          ),
          child: Checkbox(
            key: const Key('divideFirstBySecond'),
            value: _isCheckBoxSelected,
            onChanged: (value) {
              print('checkbox value: $value');
              setState(() {
                _isCheckBoxSelected = value!;
              });
              print('checkbox _isCheckBoxSelected: $_isCheckBoxSelected');
            },
          ),
        ),
        ElevatedButton(
          key: const Key('editableDateTimeNowButton'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
          ),
          onPressed: () {},
          child: const Text(
            'Now',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
          ),
          onPressed: () {},
          child: const Text(
            'Sel',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );

    return _widgetBody!;
  }
}
