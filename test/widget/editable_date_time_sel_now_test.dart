import 'package:flutter/material.dart';
import 'package:flutter_explore/flutter_editable_date_time_stateless/editable_date_time.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final Finder nextMonthIcon = find.byWidgetPredicate((Widget w) =>
      w is IconButton && (w.tooltip?.startsWith('Next month') ?? false));
  final Finder previousMonthIcon = find.byWidgetPredicate((Widget w) =>
      w is IconButton && (w.tooltip?.startsWith('Previous month') ?? false));

  TextEditingController dateTimePickerController = TextEditingController();

  group(
    'EditableDateTime widget testing',
    () {
      testWidgets(
        'Setting date day only',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: EditableDateTime(
                  dateTimeTitle: 'Date time',
                  dateTimePickerController: dateTimePickerController,
                ),
              ),
            ),
          );

          dateTimePickerController.text = '2022-09-20 12:45';

          TextField textField =
              tester.widget(find.byKey(const Key('editableDateTimeTextField')));

          expect(textField.controller!.text, '2022-09-20 12:45');

          await tester.tap(find.byKey(const Key('editableDateTimeTextField')));
          await tester.pumpAndSettle();
          await tester.tap(find.text('14')); // set day
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();
          await tester.tap(find.text('OK'));

          expect(textField.controller!.text, '2022-09-14 12:45');
        },
      );
      testWidgets(
        'Selecting previous date month and setting day only',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: EditableDateTime(
                  dateTimeTitle: 'Date time',
                  dateTimePickerController: dateTimePickerController,
                ),
              ),
            ),
          );

          dateTimePickerController.text = '2022-09-20 12:45';

          TextField textField =
              tester.widget(find.byKey(const Key('editableDateTimeTextField')));

          expect(textField.controller!.text, '2022-09-20 12:45');

          await tester.tap(find.byKey(const Key('editableDateTimeTextField')));
          await tester.pumpAndSettle();
          await tester.tap(previousMonthIcon);
          await tester.pumpAndSettle(const Duration(seconds: 1));
          await tester.tap(find.text('6')); // set day
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();
          await tester.tap(find.text('OK'));

          expect(textField.controller!.text, '2022-08-06 12:45');
        },
      );
    },
  );
}

void handleEndDateTimeChange(String endDateTimeEnglishFormatStr) {
  // print('handleEndDateTimeChange() $endDateTimeEnglishFormatStr');
}

void handleEndDateTimeSelected(String endDateTimeFrenchFormatStr) {
  // print('handleEndDateTimeSelected() $endDateTimeFrenchFormatStr');
}
