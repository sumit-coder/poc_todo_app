// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:math';

import 'package:poc_demo_app/models/links.dart';
import 'package:poc_demo_app/models/task.dart';
import 'package:http/http.dart' as http;

class ApiService {
  late String baseUrl = 'https://nodetodoserver.herokuapp.com/api/';

  //{DELETE} /todos/2
  //{GET} /todos
  //{GET 1} /todos/1(id)
  //{POST} /todos/1(id) { "task": "To swim", "due_date": "2022-05-06"}

  Future<List<Task>?> getTodos() async {
    dynamic pageData = await getTodoPageData(1);

    if (pageData != null) {
      // converting task list to json
      var jsonData = jsonEncode(pageData['data']);
      // converting json task list to List of Task's For StateManagement
      List<Task> listOfTaskFromAPI = taskFromJson(jsonData);

      return listOfTaskFromAPI;
    } else {
      return null;
    }
  }

  Future<Map?> getTodosOfNextPage(int pageNo) async {
    if (pageNo >= 2) {
      // only runs if target page no is 2 More then 2
      dynamic pageData = await getTodoPageData(pageNo);

      if (pageData != null) {
        // converting task list and page Link to json
        var jsonDataLinks = jsonEncode(pageData['links']);
        var jsonDataTasks = jsonEncode(pageData['data']);
        // converting json task list and page Links For StateManagement
        Links pageLinkFromAPI = linksFromJson(jsonDataLinks);
        List<Task> listOfTaskFromAPI = taskFromJson(jsonDataTasks);

        return {
          'tasks': listOfTaskFromAPI,
          'links': pageLinkFromAPI,
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  dynamic getTodoPageData(int pageNumber) async {
    Uri url;
    if (pageNumber >= 2) {
      // only called when Request for Second And more Page Data Needed
      url = Uri.parse('$baseUrl/todos?page=$pageNumber');
    } else {
      url = Uri.parse('$baseUrl/todos');
    }
    try {
      //
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        decodedData['data'];
        return decodedData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> addTodo(Task taskToAdd) async {
    Uri url = Uri.parse('$baseUrl/todos');
    try {
      //
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(taskToAdd),
      );
      // print(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    Uri url = Uri.parse('${baseUrl}/todos/${id}');
    try {
      //
      http.Response response = await http.delete(url);

      // print(response.statusCode);

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo({required int id, required Task newTask}) async {
    Uri url = Uri.parse('${baseUrl}/todos/${id}');
    try {
      http.Response response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newTask),
      );

      // print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
