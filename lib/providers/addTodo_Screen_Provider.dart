import 'package:flutter/foundation.dart';

class AddTodoScreenProvider with ChangeNotifier {
  DateTime? dueDate;
  String todoTitle = '';
  bool isCompleted = false;

  setTodoText(String newValue) {
    todoTitle = newValue;

    notifyListeners();
  }
}
