import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TextEditingController controller = TextEditingController(text: 'Hello world');

  testWidgets(
    'TestField onTap/onDoubleTap test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                child: TextField(
                  key: const Key('textField'),
                  controller: controller,
                  onTap: () => print('TextField onTap: detected'),
                  readOnly: true,
                ),
                onDoubleTap: () =>
                    print('GestureDetector onDoubleTap: detected'),
              ),
            ),
          ),
        ),
      );

      Finder textFieldFinder = find.byKey(const ValueKey("textField"));
      final TextField textField = tester.widget(textFieldFinder);
      expect(textField.controller!.text, 'Hello world');

      print('testing onTap twice');
      await tester.tap(textFieldFinder);
      await tester.pumpAndSettle();
      await tester.tap(textFieldFinder);
      await tester.pumpAndSettle();
    },
  );
}
