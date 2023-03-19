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

  factory MyOtherClass.fromJson(Map<String, dynamic> json) {
    return MyOtherClass(
      name: json['name'],
      color:
          Color.values.firstWhere((color) => color.toString() == json['color']),
      items: List<String>.from(json['items']),
      properties: Map<String, dynamic>.from(json['properties']),
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

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      name: json['name'],
      color:
          Color.values.firstWhere((color) => color.toString() == json['color']),
      size: Size.values.firstWhere((size) => size.toString() == json['size']),
      items: List<String>.from(json['items']),
      properties: Map<String, dynamic>.from(json['properties']),
      otherClass: MyOtherClass.fromJson(json['otherClass']),
      otherClasses: (json['otherClasses'] as List<dynamic>)
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

  void saveToFile(String path) {
    String jsonStr = json.encode(toJson());
    printJsonString(
      methodName: 'saveToFile',
      jsonStr: jsonStr,
    );
    File(path).writeAsStringSync(jsonStr);
  }

  static void printJsonString({
    required String methodName,
    required String jsonStr,
  }) {
    String prettyJson =
        JsonEncoder.withIndent('  ').convert(json.decode(jsonStr));
    print('$methodName:\n$prettyJson');
  }

  static MyClass loadFromFile(String path) {
    String jsonStr = File(path).readAsStringSync();
    printJsonString(
      methodName: 'loadFromFile',
      jsonStr: jsonStr,
    );
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    return MyClass.fromJson(jsonData);
  }
}

void main() {
  // Create an instance of MyClass
  MyOtherClass otherObj = MyOtherClass(
    name: 'Other object',
    color: Color.blue,
    items: ['item4', 'item5', 'item6'],
    properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
  );
  MyOtherClass otherObj1 = MyOtherClass(
    name: 'Other object 1',
    color: Color.blue,
    items: ['item4', 'item5', 'item6'],
    properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
  );
  MyOtherClass otherObj2 = MyOtherClass(
    name: 'Other object 2',
    color: Color.red,
    items: ['item7', 'item8', 'item9'],
    properties: {'prop7': 7, 'prop8': 'eight', 'prop9': true},
  );
  MyClass myObj = MyClass(
    name: 'My object',
    color: Color.green,
    size: Size.medium,
    items: ['item1', 'item2', 'item3'],
    properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
    otherClass: otherObj,
    otherClasses: [otherObj1, otherObj2],
  );

  // Save myObj to a JSON file
  myObj.saveToFile('myobj.json');

  // Load myObj from the JSON file
  MyClass loadedObj = MyClass.loadFromFile('myobj.json');

  // Print the loaded object
  print(loadedObj.name); // Output: My object
  print(loadedObj.color); // Output: Color.green
  print(loadedObj.size); // Output: Size.medium
  print(loadedObj.items); // Output: [item1, item2, item3]
  print(loadedObj.properties); // Output:
  print(loadedObj.otherClass); // Output:
  print(loadedObj.otherClasses); // Output:
}
