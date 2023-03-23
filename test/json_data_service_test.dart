import 'dart:convert';
import 'dart:io';
import 'package:flutter_explore/main_class_to_json.dart';
import 'package:test/test.dart';

class UnsupportedClass {}

class MyTestClass {
  final String name;
  final int value;

  MyTestClass({required this.name, required this.value});

  factory MyTestClass.fromJson(Map<String, dynamic> json) {
    return MyTestClass(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

void main() {
  const jsonPath = 'test.json';

  group('JsonDataService', () {
    tearDown(() {
      if (File(jsonPath).existsSync()) {
        File(jsonPath).deleteSync();
      }
    });

    test('saveToFile and loadFromFile should work for MyClass', () {
      MyClass myClassInstance = MyClass(
        name: 'My object',
        color: Color.green,
        size: Size.medium,
        items: ['item1', 'item2', 'item3'],
        properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
        otherClass: MyOtherClass(
          name: 'Other object',
          color: Color.blue,
          items: ['item4', 'item5', 'item6'],
          properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
        ),
        otherClasses: [
          MyOtherClass(
            name: 'Other object 1',
            color: Color.blue,
            items: ['item7', 'item8', 'item9'],
            properties: {'prop7': 7, 'prop8': 'eight', 'prop9': true},
          ),
          MyOtherClass(
            name: 'Other object 2',
            color: Color.red,
            items: ['item10', 'item11', 'item12'],
            properties: {'prop10': 10, 'prop11': 'eleven', 'prop12': false},
          ),
        ],
      );

      JsonDataService.saveToFile(model: myClassInstance, path: jsonPath);
      MyClass loadedMyClass = JsonDataService.loadFromFile(
        path: jsonPath,
        type: MyClass,
      );

      expect(loadedMyClass, isA<MyClass>());
      expect(loadedMyClass.name, myClassInstance.name);
      expect(loadedMyClass.color, myClassInstance.color);
      expect(loadedMyClass.size, myClassInstance.size);
      expect(loadedMyClass.items, myClassInstance.items);
      expect(loadedMyClass.properties, myClassInstance.properties);
      expect(loadedMyClass.otherClass.name, myClassInstance.otherClass.name);
      expect(loadedMyClass.otherClass.color, myClassInstance.otherClass.color);
      expect(loadedMyClass.otherClass.items, myClassInstance.otherClass.items);
      expect(loadedMyClass.otherClass.properties,
          myClassInstance.otherClass.properties);
      expect(loadedMyClass.otherClasses.length,
          myClassInstance.otherClasses.length);
    });
  });

  group('JsonDataService', () {
    test('ClassNotContainedInJsonFileException', () {
      // Prepare a temporary file
      File tempFile = File('temp.json');
      tempFile.writeAsStringSync(jsonEncode({'test': 'data'}));

      try {
        // Try to load a MyClass instance from the temporary file, which should throw an exception
        JsonDataService.loadFromFile(path: 'temp.json', type: MyClass);
      } catch (e) {
        expect(e, isA<ClassNotContainedInJsonFileException>());
      } finally {
        tempFile.deleteSync(); // Clean up the temporary file
      }
    });

    test('ClassNotSupportedByToJsonDataServiceException', () {
      // Create a class not supported by JsonDataService

      try {
        // Try to encode an instance of UnsupportedClass, which should throw an exception
        JsonDataService.encodeJson(UnsupportedClass());
      } catch (e) {
        expect(e, isA<ClassNotSupportedByToJsonDataServiceException>());
      }
    });

    test('ClassNotSupportedByFromJsonDataServiceException', () {
      // Create a class not supported by JsonDataService

      // Prepare a JSON string representing an instance of UnsupportedClass
      String unsupportedClassJson = jsonEncode({'test': 'data'});

      try {
        // Try to decode the JSON string into an instance of UnsupportedClass, which should throw an exception
        JsonDataService.decodeJson(unsupportedClassJson, UnsupportedClass);
      } catch (e) {
        expect(e, isA<ClassNotSupportedByFromJsonDataServiceException>());
      }
    });
  });
  group('JsonDataService', () {
    test('saveListToFile() ClassNotSupportedByToJsonDataServiceException',
        () async {
      // Prepare test data
      List<MyTestClass> testList = [
        MyTestClass(name: 'Test1', value: 1),
        MyTestClass(name: 'Test2', value: 2),
      ];

      // Save the list to a file
      try {
        // Try to decode the JSON string into an instance of UnsupportedClass, which should throw an exception
        JsonDataService.saveListToFile(path: jsonPath, data: testList);
      } catch (e) {
        expect(e, isA<ClassNotSupportedByToJsonDataServiceException>());
      }
    });
    test('saveListToFile() ClassNotSupportedByFromJsonDataServiceException', () async {
      // Prepare test data
      MyClass myClassInstance = MyClass(
        name: 'My object',
        color: Color.green,
        size: Size.medium,
        items: ['item1', 'item2', 'item3'],
        properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
        otherClass: MyOtherClass(
          name: 'Other object',
          color: Color.blue,
          items: ['item4', 'item5', 'item6'],
          properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
        ),
        otherClasses: [
          MyOtherClass(
            name: 'Other object 1',
            color: Color.blue,
            items: ['item7', 'item8', 'item9'],
            properties: {'prop7': 7, 'prop8': 'eight', 'prop9': true},
          ),
          MyOtherClass(
            name: 'Other object 2',
            color: Color.red,
            items: ['item10', 'item11', 'item12'],
            properties: {'prop10': 10, 'prop11': 'eleven', 'prop12': false},
          ),
        ],
      );

      JsonDataService.saveToFile(model: myClassInstance, path: jsonPath);

      // Load the list from the file
      try {
        List<MyTestClass> loadedList = JsonDataService.loadListFromFile(
            path: jsonPath, type: MyTestClass);
      } catch (e) {
        expect(e, isA<ClassNotSupportedByFromJsonDataServiceException>());
      }

      // Clean up the test file
      File(jsonPath).deleteSync();
    });
    test('saveListToFile() and loadListFromFile()', () async {
      MyOtherClass myOtherClassInstance = MyOtherClass(
        name: 'Other object',
        color: Color.blue,
        items: ['item4', 'item5', 'item6'],
        properties: {'prop4': 4, 'prop5': 'five', 'prop6': false},
      );

      MyClass myClassInstance = MyClass(
        name: 'My object',
        color: Color.green,
        size: Size.medium,
        items: ['item1', 'item2', 'item3'],
        properties: {'prop1': 1, 'prop2': 'two', 'prop3': true},
        otherClass: myOtherClassInstance,
        otherClasses: [myOtherClassInstance],
      );

      // Prepare test data
      List<MyClass> testList = [myClassInstance];

      // Save the list to a file
      JsonDataService.saveListToFile(
          path: jsonPath, data: testList);

      // Load the list from the file
      List<MyClass> loadedList =
          await JsonDataService.loadListFromFile(path: jsonPath, type: MyClass);

      // Check if the loaded list matches the original list
      expect(loadedList.length, testList.length);
      for (int i = 0; i < loadedList.length; i++) {
        expect(loadedList[i].name, testList[i].name);
        // Add more checks for the other properties of MyClass and MyOtherClass instances
      }

      // Clean up the test file
      File(jsonPath).deleteSync();
    });
  });
}
