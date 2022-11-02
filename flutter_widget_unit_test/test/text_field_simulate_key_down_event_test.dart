// question posted on StackOverflow: https://stackoverflow.com/questions/74278540/how-to-use-simulatekeydownevent-to-simulate-typing-a-digit-on-a-flutter-textfiel
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TextEditingController controller = TextEditingController(text: '100');

  testWidgets(
    'TestField simulateKeyDownEvent test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(
                key: const Key('textField'),
                controller: controller,
              ),
            ),
          ),
        ),
      );

      Finder textFieldFinder = find.byKey(const ValueKey("textField"));
      final TextField textField = tester.widget(textFieldFinder);

      expect(textField.controller!.text, '100'); // ok

      await tester.tap(textFieldFinder);
      await simulateKeyDownEvent(LogicalKeyboardKey.backspace);

      expect(textField.controller!.text, '10'); // ok

      await tester.tap(textFieldFinder);
      await simulateKeyDownEvent(LogicalKeyboardKey.digit3);

      expect(textField.controller!.text, '103'); // not ok: 10 instead of 103
    },
  );
}
