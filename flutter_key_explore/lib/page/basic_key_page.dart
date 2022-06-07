import 'package:flutter/material.dart';
import 'package:flutter_key_explore/main.dart';
import 'package:flutter_key_explore/utils.dart';

class BasicKeyPage extends StatefulWidget {
  @override
  _BasicKeyPageState createState() => _BasicKeyPageState();
}

class _BasicKeyPageState extends State<BasicKeyPage> {
  bool showEmail = true;
  Icon? icon;
  Text? label = Text('hello');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Utils.heightBetween(
                [
                  Row(
                    children: [
                      Text("always included"),
                      SizedBox(width: 6),
                      ...skipNulls([
                        icon,
                        label,
                        label,
                      ]),
                    ],
                  ),
                  if (showEmail) 
                    const TextField(
                      key: ValueKey(MyObject(1)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  const TextField(
                    key: ValueKey(MyObject(2)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ],
                height: 16,
              ),
            ),
          ),
        ),
        floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ),
          icon: Icon(Icons.visibility_off),
          label: Text('Remove Email'),
          onPressed: () => setState(() => showEmail = false),
        ),
      );
}

skipNulls<Widget>(List<Widget> items) {
  return items..removeWhere((item) => item == null);
}

class MyObject {
  final int number;

  const MyObject(this.number);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyObject &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;
}
