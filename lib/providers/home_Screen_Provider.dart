import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:poc_demo_app/models/links.dart';
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
  bool retryButtonNeed = false;

  int currentPageNoOfTodos = 1;

  Future<bool> getTasks() async {
    // print('object');
    // Check is Data is Loaded From API or Not
    if (tasksLodedeFromApi == false) {
      // if Data is not Loaded From API Then Load Data Form Api
      ApiService apiService = ApiService();

      List<Task>? tasksListFromApi = await apiService.getTodos(); // Todo = Task

      if (tasksListFromApi != null) {
        taskList = tasksListFromApi;
        tasksLodedeFromApi = true;
        currentPageNoOfTodos = 1;
        notifyListeners();
        return true;
      } else {
        retryButtonNeed = true;
        notifyListeners();
        return false;
      }
    } else {
      // if Data is Allready Loaded From Api
      return true;
    }
  }

  // lazyLoadingLoadTodos Function add new Task for Next Pages To taskList
  void lazyLoadingLoadTodos() async {
    ApiService apiService = ApiService();
    Map? newPageDataAndTodos =
        await apiService.getTodosOfNextPage(currentPageNoOfTodos + 1);

    // this Check is Api Respose is not null if it do Nothing (if no more pages then do nothing)
    if (newPageDataAndTodos != null) {
      // this will split List of Task And Links Form Api Response (Json to Models)
      List<Task> nextPageTodoList = newPageDataAndTodos['tasks'];
      Links nextPageLinksData = newPageDataAndTodos['links'];

      // Combine old Task list with NextPage TaskList
      List<Task> newTaskList = [...taskList, ...nextPageTodoList];

      // setting oldTask to newTaskList
      taskList = newTaskList;
      // addign current page count;
      currentPageNoOfTodos = currentPageNoOfTodos + 1;
      // notifying to Listeners
      notifyListeners();
    } else {}
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
