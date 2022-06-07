import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAlarmOn = false;
  int alarmId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Alarm'),
              Switch(
                value: isAlarmOn,
                onChanged: (value) {
                  setState(() {
                    isAlarmOn = value;
                  });
                  if (isAlarmOn == true) {
                    AndroidAlarmManager.oneShot(
                      const Duration(seconds: 5),
                      alarmId,
                      fireAlarm,
                      alarmClock: true,
                    );
                  } else {
                    AndroidAlarmManager.cancel(alarmId);
                    print('Alarm Timer Canceled');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void fireAlarm(int alarmId) {
  print('Alarm id $alarmId Fired at ${DateTime.now()}');
}
