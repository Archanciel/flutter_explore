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

typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);

class JsonDataService {
// typedef FromJsonFunction<T> = T Function(Map<String, dynamic> jsonDataMap);
  static Map<Type, FromJsonFunction> _fromJsonFunctionsMap = {
    MyOtherClass: (jsonDataMap) => MyOtherClass.fromJson(jsonDataMap),
  };

// typedef ToJsonFunction<T> = Map<String, dynamic> Function(T model);
  static Map<Type, ToJsonFunction> _toJsonFunctionsMap = {
    MyOtherClass: (model) => model.toJson(),
  };

  static String encodeJson(dynamic data) {
    if (data is List) {
      if (data.isNotEmpty) {
        final type = data.first.runtimeType;
        final toJsonFunction = _toJsonFunctionsMap[type];
        if (toJsonFunction != null) {
          return jsonEncode(data.map((e) => toJsonFunction(e)).toList());
        }
      }
    } else {
      final type = data.runtimeType;
      final toJsonFunction = _toJsonFunctionsMap[type];
      if (toJsonFunction != null) {
        return jsonEncode(toJsonFunction(data));
      }
    }

    return '';
  }

  // static dynamic decodeJson(String jsonString, Type type) {
  //   final fromJsonFunction = _fromJsonFunctionsMap[type];
  //   if (fromJsonFunction != null) {
  //     final jsonData = jsonDecode(jsonString);
  //     if (jsonData is List) {
  //       if (jsonData.isNotEmpty) {
  //         final list = jsonData.map((e) => fromJsonFunction(e)).toList();
  //         return list;
  //       } else {
  //         return <dynamic>[];
  //       }
  //     } else {
  //       return fromJsonFunction(jsonData);
  //     }
  //   }
  //   return null;
  // }

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
        throw Exception('Expected a JSON array, but got a JSON object');
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

  String myOtherClassListJsonStr = JsonDataService.encodeJson(
      [myOtherClassInstance_1, myOtherClassInstance_2]);
  JsonDataService.printJsonString(
      methodName: 'myOtherClassListJsonStr', jsonStr: myOtherClassListJsonStr);

  List<MyOtherClass> myOtherClassListDecodedInstance =
      JsonDataService.decodeJsonList(myOtherClassListJsonStr, MyOtherClass);

  print('myClassDecodedInstance: $myOtherClassListDecodedInstance');
}


// How can I put this Code

//   List<MyOtherClass> myOtherClassListDecodedInstance =
//       dynamicListDecodedInstance.map((dynamic e) => e as MyOtherClass).toList();

// into JsonDataService.decodeJson() method ?
