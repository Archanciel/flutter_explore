import 'dart:convert';
import 'dart:io';

enum Color { red, green, blue }

enum Size { small, medium, large }

class MyOtherClass {
  String name;
  Color color;
  List<String> items;
  Map<String, dynamic> properties;

  MyOtherClass({
    required this.name,
    required this.color,
    required this.items,
    required this.properties,
  });

  factory MyOtherClass.fromJson(Map<String, dynamic> jsonDataMap) {
    return MyOtherClass(
      name: jsonDataMap['name'],
      color: Color.values
          .firstWhere((color) => color.toString() == jsonDataMap['color']),
      items: jsonDataMap['items']
          .cast<String>(), // cast is required since json list
      // is List<dynamic>. Cast is more
      // performant than
      // List<String>.from(json['items'])
      properties: jsonDataMap['properties'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.toString(),
        'items': items,
        'properties': properties,
      };

  @override
  String toString() {
    return '$name, ${color.toString()}';
  }
}

class MyClass {
  String name;
  Color color;
  Size size;
  List<String> items;
  Map<String, dynamic> properties;
  MyOtherClass otherClass;
  List<MyOtherClass> otherClasses;

  MyClass(
      {required this.name,
      required this.color,
      required this.size,
      required this.items,
      required this.properties,
      required this.otherClass,
      required this.otherClasses});

  factory MyClass.fromJson(Map<String, dynamic> jsonDataMap) {
    return MyClass(
      name: jsonDataMap['name'],
      color: Color.values
          .firstWhere((color) => color.toString() == jsonDataMap['color']),
      size: Size.values
          .firstWhere((size) => size.toString() == jsonDataMap['size']),
      items: jsonDataMap['items']
          .cast<String>(), // cast is required since json list
      //                      is List<dynamic>. Cast is more
      //                      performant than
      //                      List<String>.from(json['items'])
      properties: jsonDataMap['properties'],
      otherClass: MyOtherClass.fromJson(jsonDataMap['otherClass']),
      otherClasses: (jsonDataMap['otherClasses'] as List<dynamic>)
          .map((item) => MyOtherClass.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.toString(),
        'size': size.toString(),
        'items': items,
        'properties': properties,
        'otherClass': otherClass.toJson(),
        'otherClasses': otherClasses.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return '$name, ${color.toString()}';
  }
}

typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);

class ClassNotContainedInJsonFileException implements Exception {
  final String _className;
  final String _jsonFilePathName;
  final StackTrace _stackTrace;

  ClassNotContainedInJsonFileException({
    required String className,
    required String jsonFilePathName,
    StackTrace? stackTrace,
  })  : _className = className,
        _jsonFilePathName = jsonFilePathName,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className not stored in $_jsonFilePathName file.\nStack Trace:\n$_stackTrace');
  }
}

class ClassNotSupportedByToJsonDataServiceException implements Exception {
  final String _className;
  final StackTrace _stackTrace;

  ClassNotSupportedByToJsonDataServiceException({
    required String className,
    StackTrace? stackTrace,
  })  : _className = className,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className has no entry in JsonDataService._toJsonFunctionsMap.\nStack Trace:\n$_stackTrace');
  }
}

class ClassNotSupportedByFromJsonDataServiceException implements Exception {
  final String _className;
  final StackTrace _stackTrace;

  ClassNotSupportedByFromJsonDataServiceException({
    required String className,
    StackTrace? stackTrace,
  })  : _className = className,
        _stackTrace = stackTrace ?? StackTrace.current;

  @override
  String toString() {
    return ('Class $_className has no entry in JsonDataService._fromJsonFunctionsMap.\nStack Trace:\n$_stackTrace');
  }
}

class JsonDataService {
  // typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
  static final Map<Type, FromJsonFunction> _fromJsonFunctionsMap = {
    MyClass: (jsonDataMap) => MyClass.fromJson(jsonDataMap),
    MyOtherClass: (jsonDataMap) => MyOtherClass.fromJson(jsonDataMap),
  };

  // typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);
  static final Map<Type, ToJsonFunction> _toJsonFunctionsMap = {
    MyClass: (model) => model.toJson(),
    MyOtherClass: (model) => model.toJson(),
  };

  static void saveToFile({
    required dynamic model,
    required String path,
  }) {
    final String jsonStr = encodeJson(model);
    File(path).writeAsStringSync(jsonStr);
  }

  static dynamic loadFromFile({
    required String path,
    required Type type,
  }) {
    final String jsonStr = File(path).readAsStringSync();

    try {
      return decodeJson(jsonStr, type);
    } catch(e) {
      throw ClassNotContainedInJsonFileException(
        className: type.toString(),
        jsonFilePathName: path,
      );
    }
  }

  static String encodeJson(dynamic data) {
    if (data is List) {
      throw Exception(
          "encodeJson() does not support encoding list's. Use encodeJsonList() instead.");
    } else {
      final type = data.runtimeType;
      final toJsonFunction = _toJsonFunctionsMap[type];
      if (toJsonFunction != null) {
        return jsonEncode(toJsonFunction(data));
      }
    }

    return '';
  }

  static dynamic decodeJson(
    String jsonString,
    Type type,
  ) {
    final fromJsonFunction = _fromJsonFunctionsMap[type];

    if (fromJsonFunction != null) {
      final jsonData = jsonDecode(jsonString);
      if (jsonData is List) {
        throw Exception(
            "decodeJson() does not support decoding list's. Use decodeJsonList() instead.");
      } else {
        return fromJsonFunction(jsonData);
      }
    }

    return null;
  }

  static void saveListToFile({
    required dynamic data,
    required String path,
  }) {
    String jsonStr = encodeJsonList(data);
    File(path).writeAsStringSync(jsonStr);
  }

  static List<T> loadListFromFile<T>({
    required String path,
    required Type type,
  }) {
    String jsonStr = File(path).readAsStringSync();

    try {
      return decodeJsonList(jsonStr, type);
    } on StateError {
      throw ClassNotContainedInJsonFileException(
        className: type.toString(),
        jsonFilePathName: path,
      );
    }
  }

  static String encodeJsonList(dynamic data) {
    if (data is List) {
      if (data.isNotEmpty) {
        final type = data.first.runtimeType;
        final toJsonFunction = _toJsonFunctionsMap[type];
        if (toJsonFunction != null) {
          return jsonEncode(data.map((e) => toJsonFunction(e)).toList());
        } else {
          throw ClassNotSupportedByToJsonDataServiceException(
            className: type.toString(),
          );
        }
      }
    } else {
      throw Exception(
          "encodeJsonList() only supports encoding list's. Use encodeJson() instead.");
    }

    return '';
  }

  static List<T> decodeJsonList<T>(
    String jsonString,
    Type type,
  ) {
    final fromJsonFunction = _fromJsonFunctionsMap[type];
    
    if (fromJsonFunction != null) {
      final jsonData = jsonDecode(jsonString);
      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          final list = jsonData.map((e) => fromJsonFunction(e)).toList();
          return list.cast<T>(); // Cast the list to the desired type
        } else {
          return <T>[]; // Return an empty list of the desired type
        }
      } else {
        throw Exception(
            "decodeJsonList() only supports decoding list's. Use decodeJson() instead.");
      }
    } else {
      throw ClassNotSupportedByFromJsonDataServiceException(
        className: type.toString(),
      );
    }
  }

  /// print jsonStr in formatted way
  static void printJsonString({
    required String methodName,
    required String jsonStr,
  }) {
    String prettyJson =
        const JsonEncoder.withIndent('  ').convert(json.decode(jsonStr));
    print('$methodName:\n$prettyJson');
  }
}

void main() {
  // Create an instance of MyClass
  MyOtherClass myOtherClassInstance = MyOtherClass(
    name: 'Other object',
    color: Color.blue,
    items: ['item4', 'item5', 'item6'],
    properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
  );

  MyOtherClass myOtherClassInstance_1 = MyOtherClass(
    name: 'Other object 1',
    color: Color.blue,
    items: ['item4', 'item5', 'item6'],
    properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
  );

  MyOtherClass myOtherClassInstance_2 = MyOtherClass(
    name: 'Other object 2',
    color: Color.red,
    items: ['item7', 'item8', 'item9'],
    properties: {'prop7': 7, 'prop8': 'eight', 'prop9': true},
  );

  MyClass myClassInstance = MyClass(
    name: 'My object',
    color: Color.green,
    size: Size.medium,
    items: ['item1', 'item2', 'item3'],
    properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
    otherClass: myOtherClassInstance,
    otherClasses: [myOtherClassInstance_1, myOtherClassInstance_2],
  );

  // Save myClassInstance to a JSON file
  JsonDataService.saveToFile(
    model: myClassInstance,
    path: 'myobj.json',
  );

  // Load myClassInstance from the JSON file
  MyClass loadedMyClass = JsonDataService.loadFromFile(
    path: 'myobj.json',
    type: MyClass,
  );

  // Print the loaded object
  print(loadedMyClass.name); // Output: My object
  print(loadedMyClass.color); // Output: Color.green
  print(loadedMyClass.size); // Output: Size.medium
  print(loadedMyClass.items); // Output: [item1, item2, item3]
  print(loadedMyClass.properties); // Output:
  print(loadedMyClass.otherClass); // Output:
  print(loadedMyClass.otherClasses); // Output:

  // Save myOtherClassInstance to a JSON file
  JsonDataService.saveToFile(
    model: myOtherClassInstance,
    path: 'myobj.json',
  );

  // Load myClassInstance from the JSON file containing myOtherClassInstance
  try {
    MyOtherClass loadedMyOtherClass = JsonDataService.loadFromFile(
      path: 'myobj.json',
      type: MyClass,
    );
  } catch (e) {
    print(e);
  }

  MyOtherClass loadedMyOtherClass = JsonDataService.loadFromFile(
    path: 'myobj.json',
    type: MyOtherClass,
  );

  // Print the loaded object
  print(loadedMyOtherClass.name); // Output: My object
  print(loadedMyOtherClass.color); // Output: Color.green
  print(loadedMyOtherClass.items); // Output: [item1, item2, item3]
  print(loadedMyOtherClass.properties); // Output:

  String myClassJsonStr = JsonDataService.encodeJson(myClassInstance);
  JsonDataService.printJsonString(
      methodName: 'myClassInstanceJsonStr', jsonStr: myClassJsonStr);

  String myOtherClassJsonStr = JsonDataService.encodeJson(myOtherClassInstance);

  JsonDataService.printJsonString(
      methodName: 'myOtherClassListJsonStr encodeJsonList()',
      jsonStr: myOtherClassJsonStr);

  // Causes Exception: encodeJsonList() only supports encoding list's. Use encodeJson() instead.
  try {
    String myOtherClassListJsonStr =
        JsonDataService.encodeJsonList(myOtherClassInstance);
  } catch (e) {
    print(e);
  }

  // Causes Exception: encodeJson() does not support encoding list's. Use encodeJsonList() instead.
  try {
    String myOtherClassListJsonStr = JsonDataService.encodeJson(
        [myOtherClassInstance_1, myOtherClassInstance_2]);
  } catch (e) {
    print(e);
  }

  String myOtherClassListJsonStr = JsonDataService.encodeJsonList(
      [myOtherClassInstance_1, myOtherClassInstance_2]);

  JsonDataService.printJsonString(
      methodName: 'myOtherClassListJsonStr encodeJsonList()',
      jsonStr: myOtherClassListJsonStr);

  MyClass myClassDecodedInstance =
      JsonDataService.decodeJson(myClassJsonStr, MyClass);
  print('myClassDecodedInstance: $myClassDecodedInstance');

  // Causes Exception: decodeJsonList() only supports decoding list's. Use decodeJson() instead.
  try {
    var myClassDecodedInstance =
        JsonDataService.decodeJsonList(myClassJsonStr, MyClass);
  } catch (e) {
    print(e);
  }

  // Causes Exception: decodeJson() does not support decoding list's. Use decodeJsonList() instead.
  try {
    List<MyOtherClass> myOtherClassListDecoded = JsonDataService.decodeJson(
        '[$myClassJsonStr, $myClassJsonStr]', MyOtherClass);
  } catch (e) {
    print(e);
  }

  List<MyOtherClass> myOtherClassListDecoded = JsonDataService.decodeJsonList(
      '[$myClassJsonStr, $myClassJsonStr]', MyOtherClass);
  print('myOtherClassListDecoded: $myOtherClassListDecoded');

  // Save myOtherClassInstance to a JSON file
  JsonDataService.saveListToFile(
    data: [myOtherClassInstance_1, myOtherClassInstance_2],
    path: 'myobj.json',
  );

  // Causes Exception: Class String has no entry in JsonDataService._toJsonFunctionsMap.
  try {
    // Save myOtherClassInstance to a JSON file
    JsonDataService.saveListToFile(
      data: [myClassJsonStr, myClassJsonStr],
      path: 'myobj.json',
    );
  } catch (e) {
    print(e);
  }

  List<MyClass> loadedMyOtherClassList = JsonDataService.loadListFromFile(
    path: 'myobj.json',
    type: MyOtherClass,
  );
}
