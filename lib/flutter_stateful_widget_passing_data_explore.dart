import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainApp',
      home: MyStatefullApp(),
    );
  }
}

class MyStatefullApp extends StatefulWidget {
  MyStatefullApp({Key? key}) : super(key: key);

  @override
  State<MyStatefullApp> createState() => _MyStatefullAppState();
}

class _MyStatefullAppState extends State<MyStatefullApp> {
  final Map<String, dynamic> widgetOneValueMap = {
    'text': 'widget one init text',
    'value': 1,
  };

  void _widgetOnSubmitFunction(Map<String, dynamic> widgetReturnedValueMap) {
    print(widgetReturnedValueMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyStatefullApp',
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              StatefullWidgetOne(
                widgetValueMap: widgetOneValueMap,
                onSubmitFunction: _widgetOnSubmitFunction,
              ),
            ],
          )),
    );
  }
}

class StatefullWidgetOne extends StatefulWidget {
  // widget values returned to the widget including instance in order
  // for it to compute on the modified values and/or transmit them
  // to the other wodgets
  Map<String, dynamic> widgetValueMap = {};

  void Function(Map<String, dynamic> widgetReturnedValueMap) onSubmitFunction;
  void updateWidgetValues(
      {required Map<String, dynamic> widgetModifiedValueMap}) {
    widgetValueMap.updateAll((key, value) => widgetModifiedValueMap[key]);
  }

  /// onSubmitFunction  passed function which is called each time the
  /// user modified a widget editable value.
  /// inputValueChangedFunction  passed function which is called each time the
  /// by the widget includer each time the widget has to get modified
  /// input values.
  StatefullWidgetOne({
    Key? key,
    required Map<String, dynamic> this.widgetValueMap,
    required void Function(Map<String, dynamic> widgetReturnedValueMap)
        this.onSubmitFunction,
  }) : super(key: key);

  @override
  State<StatefullWidgetOne> createState() => _StatefullWidgetOneState();
}

class _StatefullWidgetOneState extends State<StatefullWidgetOne> {
  late final TextEditingController _controllerText;
  late final TextEditingController _controllerValue;

  @override
  void initState() {
    _controllerText = TextEditingController(text: widget.widgetValueMap['text']);
    _controllerValue = TextEditingController(text: widget.widgetValueMap['value'].toString());

    super.initState();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerValue.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 300.0,
              child: TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                controller: _controllerText,
                onChanged: (value) {
                  // ensuring that the Text widget changed content is displayed
                  setState(
                    () {},
                  );
                },
                onSubmitted: (value) {
                  widget.widgetValueMap['text'] = _controllerText.text;
                  widget.onSubmitFunction(widget.widgetValueMap);
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 30.0,
              child: TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                controller: _controllerValue,
                onChanged: (value) {
                  // ensuring that the Text widget changed content is displayed
                  setState(
                    () {},
                  );
                },
                onSubmitted: (value) {
                  widget.widgetValueMap['value'] =
                      int.tryParse(_controllerValue.text);
                  widget.onSubmitFunction(widget.widgetValueMap);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            '${_controllerText.text} ${_controllerValue.text}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
