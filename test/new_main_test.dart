import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_explore/new_main.dart';

void main() {
  testWidgets('Compound Interest Calculator test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CompoundInterestCalculator(),
    ));

    // On vérifie que les champs de formulaire sont présents
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // On saisit des valeurs dans les champs de formulaire
    await tester.enterText(find.byType(TextFormField).at(0), '1000');
    await tester.enterText(find.byType(TextFormField).at(1), '10');
    await tester.enterText(find.byType(TextFormField).at(2), '2');

    // On appuie sur le bouton 'Calculer'
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // On vérifie que le résultat est correct
    expect(find.text('Montant final : 1210.0'), findsOneWidget);
  });
}
