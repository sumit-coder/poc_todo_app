import 'package:flutter/material.dart';

class TimeAndDate {
  DateTime addTimeOfDayWithDateTime({required DateTime? newDate, required TimeOfDay? newTime}) {
    DateTime newDateAndTime;
    if (newDate == null || newTime == null) {
      newDateAndTime = DateTime.now();
    } else {
      newDateAndTime =
          DateTime(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
    }

    return newDateAndTime;
  }

  String timeOfDayToNormalString(TimeOfDay convertTime) {
    String timeToString;
    print(convertTime);
    if (convertTime.hour < 12) {
      // This will check if hour is 0 means its 12
      timeToString =
          '${convertTime.hour == 0 ? '12' : convertTime.hour}:${convertTime.minute == 0 ? '00' : convertTime.minute} AM';
      print('AM');
    } else {
      timeToString =
          '${convertTime.hour == 12 ? '12' : convertTime.hour - 12}:${convertTime.minute == 0 ? '00' : convertTime.minute} PM';
      print("PM");
    }

    return timeToString;
  }
}
