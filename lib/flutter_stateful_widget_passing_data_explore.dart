import 'dart:math';
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
  /// Map storing the data displayed and edited by the first instance
  /// of CustomStatefullWidget
  final Map<String, dynamic> widgetOneValueMap = {
    'name': 'one',
    'text': 'widget one init text',
    'value': 1,
  };

  /// Map storing the data displayed and edited by the second instance
  /// of CustomStatefullWidget
  final Map<String, dynamic> widgetTwoValueMap = {
    'name': 'two',
    'text': 'widget two init text',
    'value': 2,
  };

  /// custom widget instanciated in initState() method
  late CustomStatefullWidget _statefullWidgetOne;

  /// custom widget instanciated in initState() method
  late CustomStatefullWidget _statefullWidgetTwo;

  @override
  void initState() {
    _statefullWidgetOne = CustomStatefullWidget(
      widgetValueMap: widgetOneValueMap,
      onSubmitFunction: _widgetOnSubmitFunction,
    );
    _statefullWidgetTwo = CustomStatefullWidget(
      widgetValueMap: widgetTwoValueMap,
      onSubmitFunction: _widgetOnSubmitFunction,
    );

    super.initState();
  }

  /// Function passed to the custom widget constructor. This function
  /// will be called each time one of the custom widget field is
  /// modified by the user and the onSubmitted() field method is
  /// executed. Its purpose is to transmit the modified widget data
  /// to the other custom widget instance in order for this intance
  /// to be modified the same way.
  void _widgetOnSubmitFunction(Map<String, dynamic> widgetReturnedValueMap) {
    print(widgetReturnedValueMap);

    if (widgetReturnedValueMap['name'] == 'one') {
      // if the value of the first custom widget was modified, the
      // value displayed by the second custom widget is the addition
      // of the two values.
      final int value =
          int.tryParse(_statefullWidgetTwo.stateInstance._controllerValue.text) ?? 0;
      final int modifiedValue = widgetReturnedValueMap['value'];
      final int totalValue = value + modifiedValue;
      widgetReturnedValueMap['value'] = totalValue;

      _statefullWidgetTwo.updateWidgetValues(
          widgetModifiedValueMap: widgetReturnedValueMap);
    } else {
      // here, custom widget 'two' was modified ...
 
      // if the value of the second custom widget was modified, the
      // value displayed by the first custom widget is the addition
      // of the first widget value and the second widget value 
      // multiplayed by 10.
     final int value =
          int.tryParse(_statefullWidgetOne.stateInstance._controllerValue.text) ?? 0;
      final int modifiedValue = widgetReturnedValueMap['value'];
      final int totalValue = value + 10 * modifiedValue;
      widgetReturnedValueMap['value'] = totalValue;
      
      _statefullWidgetOne.updateWidgetValues(
          widgetModifiedValueMap: widgetReturnedValueMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyStatefullApp',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            _statefullWidgetOne,
            const SizedBox(
              height: 30.0,
            ),
            _statefullWidgetTwo,
          ],
        ),
      ),
    );
  }
}

class CustomStatefullWidget extends StatefulWidget {
  // widget values returned to the widget including the custom widget
  // instance in order for it to compute on the modified values and/or
  // transmit them to the other custom widgets.
  Map<String, dynamic> widgetValueMap = {};

  final void Function(Map<String, dynamic> widgetReturnedValueMap)
      onSubmitFunction;

  /// widgetValueMap: contains the initial custom widget data. The
  ///                 map values are updated each time the onSubmitted()
  ///                 custom widget field is executed.
  /// onSubmitFunction: passed function which is called each time the
  ///                   user modified a widget editable field.
  CustomStatefullWidget({
    Key? key,
    required Map<String, dynamic> this.widgetValueMap,
    required void Function(Map<String, dynamic> widgetReturnedValueMap)
        this.onSubmitFunction,
  }) : super(key: key);

  /// this variable enables the CustomStatefullWidget instance to
  /// call the updateWidgetValues() method of its
  /// _CustomStatefullWidgetState instance in order to transmit
  /// to this instance the modified widget data.
  late final _CustomStatefullWidgetState stateInstance;

  @override
  State<CustomStatefullWidget> createState() {
    stateInstance = _CustomStatefullWidgetState();

    return stateInstance;
  }

  void updateWidgetValues(
      {required Map<String, dynamic> widgetModifiedValueMap}) {
    for (MapEntry<String, dynamic> entry in widgetModifiedValueMap.entries) {
      if (entry.key != 'name') {
        // custom widget name must not be modified !
        widgetValueMap[entry.key] = entry.value;
      }
    }

    stateInstance.updateWidgetValues();
  }
}

class _CustomStatefullWidgetState extends State<CustomStatefullWidget> {
  late final TextEditingController _controllerText;
  late final TextEditingController _controllerValue;

  @override
  void initState() {
    _controllerText =
        TextEditingController(text: widget.widgetValueMap['text']);
    _controllerValue =
        TextEditingController(text: widget.widgetValueMap['value'].toString());

    super.initState();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerValue.dispose();

    super.dispose();
  }

  /// This method calls setState in order for the widget to be updated.
  void updateWidgetValues() {
    _controllerText.text = widget.widgetValueMap['text'];
    _controllerValue.text = widget.widgetValueMap['value'].toString();

    setState(() {});
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
              width: 50.0,
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
