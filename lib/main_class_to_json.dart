import 'dart:convert';
import 'dart:io';

enum Color { red, green, blue }

enum Size { small, medium, large }

class MyClass {
  String name;
  Color color;
  Size size;
  List<String> items;
  Map<String, dynamic> properties;

  MyClass({
    required this.name,
    required this.color,
    required this.size,
    required this.items,
    required this.properties,
  });

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      name: json['name'],
      color:
          Color.values.firstWhere((color) => color.toString() == json['color']),
      size: Size.values.firstWhere((size) => size.toString() == json['size']),
      items: List<String>.from(json['items']),
      properties: Map<String, dynamic>.from(json['properties']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.toString(),
        'size': size.toString(),
        'items': items,
        'properties': properties,
      };

  void saveToFile(String path) {
    String jsonStr = json.encode(toJson());
    File(path).writeAsStringSync(jsonStr);
  }

  static MyClass loadFromFile(String path) {
    String jsonStr = File(path).readAsStringSync();
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    return MyClass.fromJson(jsonData);
  }
}

void main() {
  // Create an instance of MyClass
  MyClass myObj = MyClass(
    name: 'My object',
    color: Color.green,
    size: Size.medium,
    items: ['item1', 'item2', 'item3'],
    properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
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
  print(loadedObj.properties); // Output: {prop1: 1, prop2: two, prop3: true}
}
