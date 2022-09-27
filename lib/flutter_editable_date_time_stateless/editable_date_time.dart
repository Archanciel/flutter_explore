import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableDateTime extends StatelessWidget {
  EditableDateTime({
    Key? key,
    required this.dateTimeTitle,
    required this.dateTimePickerController,
  }) : super(key: key);

  static final DateFormat englishDateTimeFormat =
      DateFormat("yyyy-MM-dd HH:mm");

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  final String dateTimeTitle;
  final TextEditingController dateTimePickerController;

  void _updateDateTimePickerValues() {
    _selectedDate = _dateTime;
    _selectedTime = TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute);
    dateTimePickerController.text = englishDateTimeFormat.format(_dateTime);
  }

  // Select for Date
  Future<DateTime?> _selectDatePickerDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) {
      // User clicked on Cancel button
      return null;
    } else {
      if (selectedDate != _selectedDate) {
        _selectedDate = selectedDate;
      }
    }

    return _selectedDate;
  }

  Future<TimeOfDay?> _selectDatePickerTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (
        BuildContext context,
        Widget? childWidget,
      ) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: childWidget!,
        );
      },
    );

    if (selectedTime == null) {
      // User clicked on Cancel button
      return null;
    } else {
      if (selectedTime != _selectedTime) {
        _selectedTime = selectedTime;
      }
    }

    return _selectedTime;
  }

  Future _selectDatePickerDateTime(BuildContext context) async {
    final DateTime? date = await _selectDatePickerDate(context);

    if (date == null) {
      // User clicked on date picker dialog Cancel button. In
      // this case, the time picker dialog is not displayed and
      // the _dateTime value is not modified.
      return;
    }

    final TimeOfDay? time = await _selectDatePickerTime(context);

    if (time == null) {
      // User clicked on time picker dialog Cancel button. In
      // this case, the _dateTime value is not modified.
      return;
    }

//    setState(() {
    _dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    //  });

    dateTimePickerController.text = englishDateTimeFormat.format(_dateTime);
  }

  @override
  Widget build(BuildContext context) {
    // print('_EditableDateTimeState.build()');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateTimeTitle,
              style: TextStyle(
                color: Colors.yellow.shade300,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              // Required to fix Row exception
              // layoutConstraints.maxWidth < double.infinity.
              width: 170,
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.blue.shade900,
                  ),
                ),
                child: TextField(
                  key: const Key('editableDateTimeTextField'),
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal),
                  controller: dateTimePickerController,
                  readOnly: true,
                  onTap: () {
                    // initializing the date and time dialogs with the
                    // currently displayed date time value ...
                    DateTime currentDateTime = englishDateTimeFormat
                        .parse(dateTimePickerController.text);
                    _selectedTime =
                        TimeOfDay(hour: currentDateTime.hour, minute: currentDateTime.minute);
                    _selectedDate = currentDateTime;
                    _selectDatePickerDateTime(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
