import 'dart:convert';
import 'dart:io';

enum Color { red, green, blue }

void main() {
  // Create an instance of the enum
  Color myColor = Color.red;

  // Convert the enum instance to a string
  String colorString = myColor.toString();

  // Create a map with the enum variable name and its string representation
  Map<String, dynamic> data = {'color': colorString};

  // Convert the map to a JSON string
  String jsonData = json.encode(data);

  // Write the JSON string to a file
  File('data.json').writeAsStringSync(jsonData);

  // Read the JSON data from the file
  String newJsondata = File('data.json').readAsStringSync();

  // Parse the JSON string to a map
  Map<String, dynamic> newData = json.decode(newJsondata);

  // Retrieve the string representation of the enum instance from the map
  String newColorstring = data['color'];

  // Convert the string representation back to an enum instance
  Color newMycolor = Color.values.firstWhere((color) => color.toString() == newColorstring);

  // Print the resulting enum instance
  print(newMycolor); // Output: Color.red

}

