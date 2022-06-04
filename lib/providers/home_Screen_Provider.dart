import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:poc_demo_app/models/links.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:poc_demo_app/services/API/api.dart';

class HomeScreenProvider with ChangeNotifier {
  ApiService apiService = ApiService();

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
    Map? newPageDataAndTodos = await apiService.getTodosOfNextPage(currentPageNoOfTodos + 1);

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
    taskList.insert(0, taskToAdd);

    // Add Task to API
    apiService.addTodo(taskToAdd);

    notifyListeners();
  }

  void isCompletedTodo(int taskId, Task oldTaskData) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        // Seting task isCompleted to true or false
        bool newValueForisCompleted = taskList[i].isCompleted == true ? false : true;

        // Update isCompleted State
        taskList[i].isCompleted = newValueForisCompleted;

        // Update isCompleted to API
        Task newTaskData = oldTaskData;
        newTaskData.isCompleted = newValueForisCompleted;

        apiService.updateTodo(id: taskId, newTask: newTaskData);

        break;
      }
    }
    notifyListeners();
  }

  void updateTask(int taskId, Task newTaskData) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        taskList[i] = newTaskData;

        //  Update Todo On API
        apiService.updateTodo(
          id: taskId,
          newTask: newTaskData,
        );
      }
    }

    notifyListeners();
  }

  void deleteTask(int taskId) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i].id == taskId) {
        taskList.removeAt(i);

        //  Delete Todo On API
        apiService.deleteTodo(taskId);

        break;
      }
    }
    notifyListeners();
  }
}
