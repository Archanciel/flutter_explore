import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stack align explore',
      theme: ThemeData.dark(),
      home: MyStatefulApp(),
    );
  }
}

class MyStatefulApp extends StatefulWidget {
  MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => _MyStatefulAppState();
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  String _status = 'Wake up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'Flutter stack align TextFields Buttons explore',
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Start date time',
                        style: TextStyle(
                          color: Colors.yellow.shade300,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade900)),
                        onPressed: () {
                          print('Now pressed');
                        },
                        child: const Text(
                          'Now',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    dateMask: 'dd-MM-yyyy HH:mm',
                    use24HourFormat: true,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(
                      Icons.event,
                      color: Colors.white,
                      size: 30,
                    ),
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    onChanged: (val) => {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      Row(
                        children: [
                          Text(
                            'End date time',
                            style: TextStyle(
                              color: Colors.yellow.shade300,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade900)),
                            onPressed: () {
                              print('Now pressed');
                            },
                            child: const Text(
                              'Now',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'dd-MM-yyyy HH:mm',
                        use24HourFormat: true,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(
                          Icons.event,
                          color: Colors.white,
                          size: 30,
                        ),
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        onChanged: (val) => {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Duration',
                    style: TextStyle(
                      color: Colors.yellow.shade300,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        labelText: 'duration',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade900)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(''),
                  Container(
                    child: Text(_status),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  style: const ButtonStyle(
                    visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_status == 'Wake up') {
                        _status = 'Sleep';
                      } else {
                        _status = 'Wake up';
                      }
                    });
                  },
                  child: Text('Reset')),
            ),
          ],
        ),
      ),
    );
  }
}
