import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_front/models/filter.dart';
import 'package:task_management_front/models/subtasks.dart';
import 'package:http/http.dart' as http;

import 'http_config.dart';

class SubtaskList with ChangeNotifier {
  List<Subtask> _subtaskList = [];

  factory SubtaskList.fromJson(List data) {
    List<Subtask> fetchedList = [];
    for (var subtask in data) {
      fetchedList.add(Subtask.fromJson(subtask));
    }
    return SubtaskList.builder(fetchedList);
  }

  SubtaskList.builder(this._subtaskList);

  SubtaskList();

  Future<void> markAsDone(int? id) async {
    try {
      await http
          .put(Uri.http(HttpConfig.domain, '/tasks/subtasks/complete/$id'));
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteSubtask(int? id) async {
    try {
      await http.delete(Uri.http(HttpConfig.domain, '/tasks/subtasks/$id'));
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> getSubTaskById(int? id) async {
    try {
      var response = await http.get(Uri.http(HttpConfig.domain, '/tasks/$id'));
      var responseData = jsonDecode(response.body);
      List<Subtask> fetchedList = [];
      for (var subtask in responseData) {
        fetchedList.add(Subtask.fromJson(subtask));
      }
      _subtaskList = fetchedList;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> sortSubtaskList(int? id) async {
    try {
      var response =
          await http.get(Uri.http(HttpConfig.domain, '/tasks/subtasks/$id'));
      var responseData = jsonDecode(response.body);
      List<Subtask> fetchedList = [];
      for (var subtask in responseData) {
        fetchedList.add(Subtask.fromJson(subtask));
      }
      _subtaskList = fetchedList;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> filterSubtask(int? id, Filter filter) async {
    final params = {
      'taskType': filter.type?.index,
      'deadline': DateFormat('dd-MM-yyyy HH:mm').format(filter.deadline)
    };
    try {
      var response = await http.post(
        Uri.http(HttpConfig.domain, '/tasks/subtasks/filters/$id'),
        headers: HttpConfig.headers,
        body: jsonEncode(params),
      );
      var responseData = jsonDecode(response.body);
      List<Subtask> fetchedList = [];
      for (var subtask in responseData) {
        fetchedList.add(Subtask.fromJson(subtask));
      }
      _subtaskList = fetchedList;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Subtask> get subtaskList {
    return [..._subtaskList];
  }
}
