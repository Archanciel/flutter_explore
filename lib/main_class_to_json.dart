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
      // is List<dynamic>. Cast is more
      // performant than
      // List<String>.from(json['items'])
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

class JsonDataService {
  static void saveToFile({
    required dynamic model,
    required String path,
  }) {
    String jsonStr = encodeJson(model);
    printJsonString(
      methodName: 'saveToFile',
      jsonStr: jsonStr,
    );
    File(path).writeAsStringSync(jsonStr);
  }

  static MyClass loadFromFile({
    required String path,
  }) {
    String jsonStr = File(path).readAsStringSync();
    printJsonString(
      methodName: 'loadFromFile',
      jsonStr: jsonStr,
    );
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    return MyClass.fromJson(jsonData);
  }

// not able to use the next methods. Need to ask ChatGPT !

// typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
  static Map<Type, FromJsonFunction> _fromJsonFunctionsMap = {
    MyClass: (jsonDataMap) => MyClass.fromJson(jsonDataMap),
    MyOtherClass: (jsonDataMap) => MyOtherClass.fromJson(jsonDataMap),
  };

// typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);
  static Map<Type, ToJsonFunction> _toJsonFunctionsMap = {
    MyClass: (model) => model.toJson(),
    MyOtherClass: (model) => model.toJson(),
  };

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

  static dynamic decodeJson(String jsonString, Type type) {
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

  static String encodeJsonList(dynamic data) {
    if (data is List) {
      if (data.isNotEmpty) {
        final type = data.first.runtimeType;
        final toJsonFunction = _toJsonFunctionsMap[type];
        if (toJsonFunction != null) {
          return jsonEncode(data.map((e) => toJsonFunction(e)).toList());
        }
      }
    } else {
      throw Exception(
          "encodeJsonList() only supports encoding list's. Use encodeJson() instead.");
    }

    return '';
  }

  static List<T> decodeJsonList<T>(String jsonString, Type type) {
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
    }
    throw Exception('fromJsonFunction not found for type: $type');
  }

  /// print jsonStr in formatted way
  static void printJsonString({
    required String methodName,
    required String jsonStr,
  }) {
    String prettyJson =
        JsonEncoder.withIndent('  ').convert(json.decode(jsonStr));
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
  MyClass loadedObj = JsonDataService.loadFromFile(path: 'myobj.json');

  // Print the loaded object
  print(loadedObj.name); // Output: My object
  print(loadedObj.color); // Output: Color.green
  print(loadedObj.size); // Output: Size.medium
  print(loadedObj.items); // Output: [item1, item2, item3]
  print(loadedObj.properties); // Output:
  print(loadedObj.otherClass); // Output:
  print(loadedObj.otherClasses); // Output:

  String myClassJsonStr = JsonDataService.encodeJson(myClassInstance);
  JsonDataService.printJsonString(
      methodName: 'myClassInstanceJsonStr', jsonStr: myClassJsonStr);

  String myOtherClassJsonStr = JsonDataService.encodeJson(myOtherClassInstance);

  JsonDataService.printJsonString(
      methodName: 'myOtherClassListJsonStr encodeJsonList()',
      jsonStr: myOtherClassJsonStr);

  try {
    String myOtherClassListJsonStr =
        JsonDataService.encodeJsonList(myOtherClassInstance);
  } catch (e) {
    print(e);
  }

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
 
  try {
    var myClassDecodedInstance =
        JsonDataService.decodeJsonList(myClassJsonStr, MyClass);
  } catch (e) {
    print(e);
  }

  try {
    List<MyOtherClass> myOtherClassListDecoded = JsonDataService.decodeJson(
        '[$myClassJsonStr, $myClassJsonStr]', MyOtherClass);
  } catch (e) {
    print(e);
  }

  List<MyOtherClass> myOtherClassListDecoded = JsonDataService.decodeJsonList(
      '[$myClassJsonStr, $myClassJsonStr]', MyOtherClass);
  print('myOtherClassListDecoded: $myOtherClassListDecoded');
}
