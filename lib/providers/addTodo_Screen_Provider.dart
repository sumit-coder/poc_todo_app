import 'package:flutter/foundation.dart';

class AddTodoScreenProvider with ChangeNotifier {
  DateTime? dueDate;
  String todoTitle = '';
  bool? isCompleted;

  setTodoText(String newValue) {
    todoTitle = newValue;

    notifyListeners();
  }

  setIsCompleted(bool? newValue) {
    isCompleted = newValue;

    notifyListeners();
  }
}
