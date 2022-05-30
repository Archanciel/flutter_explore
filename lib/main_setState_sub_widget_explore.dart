/*
Here's a full code example in which 3 sub widgets are created and inserted in
the main widget. Each widget displays in a local Text instance the value of its
counter. Clicking on the first and second widget button increments all three
counters, but as only the local setState() is called, only the widget Text
instance is updated. On the contrary, the third widget button calls the main
widget setState() as well as the local setState(), and so the third widget Text
instance is updated as well as the main widget three Text instances; the first
and second widget Text instances are not updated.
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterSubWidgetOne = 0;
  int _counterSubWidgetTwo = 0;
  int _counterSubWidgetThree = 0;

  int get counterSubWidgetOne => _counterSubWidgetOne;
  int get counterSubWidgetTwo => _counterSubWidgetTwo;
  int get counterSubWidgetThree => _counterSubWidgetThree;

  late Widget _mySubWidgerOne;
  late Widget _mySubWidgetTwo;
  late Widget _mySubWidgetThree;

  @override
  void initState() {
    super.initState();

    _mySubWidgerOne = SubWidgetOne(parent: this);
    _mySubWidgetTwo = SubWidgetTwo(parent: this);
    _mySubWidgetThree = SubWidgetThree(parent: this);
  }

  void increaseAllCounters() {
    _counterSubWidgetOne++;
    _counterSubWidgetTwo++;
    _counterSubWidgetThree++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setState sub widget explore"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Parent Text\'s'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$_counterSubWidgetOne'),
                const SizedBox(
                  width: 6,
                ),
                Text('$_counterSubWidgetTwo'),
                const SizedBox(
                  width: 6,
                ),
                Text('$_counterSubWidgetThree'),
              ],
            ),
          ],
        ),
        _mySubWidgerOne,
        _mySubWidgetTwo,
        _mySubWidgetThree,
      ],
    );
  }
}

class SubWidgetOne extends StatefulWidget {
  final _MyHomePageState _parent;

  const SubWidgetOne({Key? key, required _MyHomePageState parent})
      : _parent = parent,
        super(key: key);

  @override
  State<SubWidgetOne> createState() => _SubWidgetOneState();
}

class _SubWidgetOneState extends State<SubWidgetOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("SubWidgetOne"),
          Text('${widget._parent.counterSubWidgetOne}'),
          FloatingActionButton(
            onPressed: () {
              widget._parent.increaseAllCounters();
              setState(() {}); // updates local Text instance
            },
            child: const Icon(Icons.add),
            tooltip: 'Increases all counters, calls only local setState()',
          )
        ],
      ),
    );
  }
}

class SubWidgetTwo extends StatefulWidget {
  final _MyHomePageState _parent;

  const SubWidgetTwo({Key? key, required _MyHomePageState parent})
      : _parent = parent,
        super(key: key);

  @override
  State<SubWidgetTwo> createState() => _SubWidgetTwoState();
}

class _SubWidgetTwoState extends State<SubWidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("SubWidgetTwo"),
          Text('${widget._parent.counterSubWidgetTwo}'),
          FloatingActionButton(
            onPressed: () {
              widget._parent.increaseAllCounters();
              setState(() {}); // updates local Text instance
            },
            child: const Icon(Icons.add),
            tooltip: 'Increases all counters, calls only local setState()',
          )
        ],
      ),
    );
  }
}

class SubWidgetThree extends StatefulWidget {
  final _MyHomePageState _parent;

  const SubWidgetThree({Key? key, required _MyHomePageState parent})
      : _parent = parent,
        super(key: key);

  @override
  State<SubWidgetThree> createState() => _SubWidgetThreeState();
}

class _SubWidgetThreeState extends State<SubWidgetThree> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("SubWidgetThree"),
          Text('${widget._parent.counterSubWidgetThree}'),
          FloatingActionButton(
            onPressed: () {
              widget._parent.increaseAllCounters();
              widget._parent.setState(() {}); // updates parent Text instances
              setState(() {}); // updates local Text instance
            },
            child: const Icon(Icons.add),
            tooltip:
                'Increases all counters, calls parent setState() as well as local setState()',
          )
        ],
      ),
    );
  }
}
