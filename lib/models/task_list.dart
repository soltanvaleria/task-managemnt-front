import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task_management_front/models/task.dart';
import 'package:http/http.dart' as http;

import 'http_config.dart';

class TaskList with ChangeNotifier {
  List<Task> _taskList = [];

  Future<void> fetchTaskList() async {
    try{
      var requestResponse = await http.get(Uri.http(HttpConfig.domain, '/tasks'));
      var requestData = jsonDecode(requestResponse.body) as List;
      List<Task> fetchedList = [];
      for (var task in requestData){
        fetchedList.add(Task.fromJson(task));
      }
      this._taskList = fetchedList;
      notifyListeners();
    }
    catch(error){
      print(error);
    }
  }

  List<Task> get getTaskList {
    return [..._taskList];
  }
}
