import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TextButton.icon test', (WidgetTester tester) async {
    const IconData iconData = Icons.add;

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: TextButton.icon(
            onPressed: () { },
            icon: const Icon(iconData),
            label: const Text('text button'),
          ),
        ),
      ),
    );
    final dynamic textButtonWithIconWidget = tester.widget(find.byWidgetPredicate((Widget widget) => '${widget.runtimeType}' == '_TextButtonWithIconChild'));
    expect(textButtonWithIconWidget.icon.icon, iconData); // MODIFIED CODE. NOW WORKS !
  });
}