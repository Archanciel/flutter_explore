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
  String new_jsonData = File('data.json').readAsStringSync();

  // Parse the JSON string to a map
  Map<String, dynamic> new_data = json.decode(new_jsonData);

  // Retrieve the string representation of the enum instance from the map
  String new_colorString = data['color'];

  // Convert the string representation back to an enum instance
  Color new_myColor = Color.values.firstWhere((color) => color.toString() == '$new_colorString');

  // Print the resulting enum instance
  print(new_myColor); // Output: Color.red

}

