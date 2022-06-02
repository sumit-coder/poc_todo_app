import 'package:flutter/cupertino.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:poc_demo_app/services/API/api.dart';

class HomeScreenProvider with ChangeNotifier {
  List<Task> taskList = [
    Task(
      id: 55,
      task: 'Make a Game',
      isCompleted: false,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      userId: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Task(
      id: 56,
      task: 'Watch Youtube Video',
      isCompleted: true,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      userId: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Task(
      id: 57,
      task: 'Make New App',
      isCompleted: true,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      userId: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Task(
      id: 58,
      task: 'Make New App',
      isCompleted: true,
      dueDate: DateTime.now().add(const Duration(days: 5)),
      userId: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  bool tasksLodedeFromApi = false;

  Future<List<Task>> getTasks(int pageNo) async {
    List<Task>? listOfTaskToAdd = await ApiService().getTodos();

    if (listOfTaskToAdd != null) {
      taskList = listOfTaskToAdd;
      tasksLodedeFromApi = true;
      notifyListeners();
      return taskList;
    } else {
      return taskList;
    }
  }

  void addTask(Task taskToAdd) async {
    taskList.add(taskToAdd);

    notifyListeners();

    // add todo to Database
    // if (await ApiService().addTodo(taskToAdd)) {
    //   print('added to DB');
    // }
  }

  void isCompletedTodo(int taskId) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        // Seting task isCompleted to true or false
        taskList[i].isCompleted == true
            ? taskList[i].isCompleted = false
            : taskList[i].isCompleted = true;

        break;
      }
    }
    notifyListeners();
  }

  void deleteTask(int taskId) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        taskList.removeAt(i);

        break;
      }
    }
    notifyListeners();
  }
}
