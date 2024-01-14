// https://flutterguide.com/date-and-time-picker-in-flutter/#:~:text=To%20create%20a%20DatePicker%20and,the%20user%20confirms%20the%20dialog.

import 'package:flutter/material.dart';
import 'package:flutter_explore/flutter_editable_date_time_stateless/editable_date_time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('MyApp.build()');
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterEditableDateTimeScreen(),
    );
  }
}

class FlutterEditableDateTimeScreen extends StatefulWidget {
  const FlutterEditableDateTimeScreen({Key? key}) : super(key: key);

  @override
  State<FlutterEditableDateTimeScreen> createState() =>
      _FlutterEditableDateTimeScreenState();

  void handleEndDateTimeChange(String endDateTimeEnglishFormatStr) {
    print('handleEndDateTimeChange() $endDateTimeEnglishFormatStr');
  }

  void handleEndDateTimeSelected(String endDateTimeFrenchFormatStr) {
    print('handleEndDateTimeSelected() $endDateTimeFrenchFormatStr');
  }
}

class _FlutterEditableDateTimeScreenState
    extends State<FlutterEditableDateTimeScreen> {
  late TextEditingController dateTimePickerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dateTimePickerController = TextEditingController(
        text: EditableDateTime.englishDateTimeFormat.format(DateTime.now()));

    String nowStr = EditableDateTime.englishDateTimeFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // print('_FlutterEditableDateTimeScreenState.build()');
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Flutter Date Timer Picker'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.blue,
        margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 0.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  EditableDateTime(
                    dateTimeTitle: 'Date time',
                    dateTimePickerController: dateTimePickerController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
