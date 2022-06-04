import 'package:flutter/material.dart';
import 'package:poc_demo_app/models/task.dart';

import '../services/microFunctions/timeAndDate.dart';

class AddTodoScreenProvider with ChangeNotifier {
  DateTime? dueDate;
  TimeOfDay? dueTime;
  String todoTitle = '';
  TextEditingController? todoTitleTextController = TextEditingController();
  bool? isCompleted;

  // { | Due Date | Section UI Variable }

  // { | Due Date  | Section UI Variable }
  Color dueDatetextColor = Colors.black;
  Color dueDatebackgroundColor = Colors.white;
  String dueDateText = 'Today';
  // { | Due Time | Section UI Variable }
  Color dueTimetextColor = Colors.black;
  Color dueTimebackgroundColor = Colors.white;
  String dueTimeText = '12:00 AM';
  // { | Due Date | Section UI Variable }

  setTodoText(String newValue) {
    todoTitle = newValue;

    notifyListeners();
  }

  updateTodoText(String oldTodoText) {
    if (todoTitleTextController != null) {
      todoTitleTextController!.text = oldTodoText;
      todoTitle = oldTodoText;
    }
    notifyListeners();
  }

  setDueDate(DateTime? newValue) {
    if (newValue != null) {
      String dateToString = '${newValue.year}/${newValue.month}/${newValue.day}';

      dueDate = newValue;
      dueDateText = dateToString;
      dueDatetextColor = Colors.white;
      dueDatebackgroundColor = Colors.blue;
    }

    notifyListeners();
  }

  setDueTime(TimeOfDay? newValue) {
    if (newValue != null) {
      String timeToString = TimeAndDate().timeOfDayToNormalString(newValue);

      dueTime = newValue;
      dueTimeText = timeToString;
      dueTimetextColor = Colors.white;
      dueTimebackgroundColor = Colors.blue;
    }

    notifyListeners();
  }

  setIsCompleted(bool? newValue) {
    isCompleted = newValue;

    notifyListeners();
  }

  emptyAllFields() {
    dueDate = null;
    dueTime = null;
    todoTitle = '';
    isCompleted = null;
    todoTitleTextController?.text = '';

    // { | Due Date  | Section UI Variable }
    dueDatetextColor = Colors.black;
    dueDatebackgroundColor = Colors.white;
    dueDateText = 'Today';
    // { | Due Time | Section UI Variable }
    dueTimetextColor = Colors.black;
    dueTimebackgroundColor = Colors.white;
    dueTimeText = '12:00 AM';
  }
}
