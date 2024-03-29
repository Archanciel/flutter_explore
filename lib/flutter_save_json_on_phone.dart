import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

const String kFileName = 'myJsonFile.json';
const InputDecoration kInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  labelText: 'Label Text',
);
const TextStyle kInputTextStyle = TextStyle(
  fontSize: 22,
  color: Colors.blue,
);

const TextStyle kTextStyle = TextStyle(
  fontSize: 19.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controllerKey, _controllerValue;
  bool _fileExists = false;
  late File _filePath;

  // First initialization of _json (if there is no json in the file)
  Map<String, dynamic> _json = {};
  late String _jsonString;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  void _writeJson(String key, dynamic value) async {
    // Initialize the local _filePath
    //final _filePath = await _localFile;

    //1. Create _newJson<Map> from input<TextField>
    Map<String, dynamic> _newJson = {key: value};
    print('1.(_writeJson) _newJson: $_newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(_newJson);
    print('2.(_writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath.writeAsString(_jsonString);
  }

  void _readJson() async {
    // Initialize _filePath
    _filePath = await _localFile;

    // 0. Check whether the _file exists
    _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        _jsonString = await _filePath.readAsString();
        print('1.(_readJson) _jsonString: $_jsonString');

        //2. Update initialized _json by converting _jsonString<String>->_json<Map>
        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Instantiate _controllerKey and _controllerValue
    _controllerKey = TextEditingController();
    _controllerValue = TextEditingController();
    print('0. Initialized _json: $_json');
    _readJson();
  }

  @override
  void dispose() {
    _controllerKey.dispose();
    _controllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create JSON File'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'JSON: ',
                style: kTextStyle,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Text(
                  _json.toString(),
                  style: kTextStyle,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Add to JSON file',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.blue),
              ),
              MyInputWidget(
                controller: _controllerKey,
                label: 'Key',
              ),
              MyInputWidget(
                controller: _controllerValue,
                label: 'Value',
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  print(
                      '0. Input key: ${_controllerKey.text}; Input value: ${_controllerValue.text}\n-\n');
                  _writeJson(_controllerKey.text, _controllerValue.text);
                  final file = await _localFile;
                  _fileExists = await file.exists();
                  //_fileName = file;

                  setState(() {});
                  _controllerKey.clear();
                  _controllerValue.clear();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(100, 50) // put the width and height you want
                    ),
                child: const Text(
                  'Add {Key, Value} pair',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      _fileExists
                          ? _filePath.toString()
                          : 'File doesn\'t exist.',
                      style: kTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const MyInputWidget({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 15,
      ),
      child: TextField(
        controller: controller,
        decoration: kInputDecoration.copyWith(labelText: label),
        style: kInputTextStyle,
      ),
    );
  }
}
