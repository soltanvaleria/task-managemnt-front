import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task_management_front/models/task.dart';
import 'package:http/http.dart' as http;

import 'http_config.dart';

class TaskList with ChangeNotifier {
  List<Task> _taskList = [];

  Future<void> fetchTaskList() async {
    // var requestResponse = await http.get(Uri.http(HttpConfig.domain, '/tasks'));
    // // var requestData = jsonDecode(requestResponse.body); pentru un singur dto
    // var requestData = jsonDecode(requestResponse.body) as List;
    // List<Test> fetchedList = [];
    // for (var element in requestData) {
    //   fetchedList.add(Test.fromJson(element));
    // }
    // // var requestedTest = Test.fromJson(requestData);
    // // print(requestedTest);
    // _testList = fetchedList;
    // notifyListeners();
  }

}
