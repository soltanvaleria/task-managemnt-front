import 'dart:convert';

import 'package:task_management_front/models/http_config.dart';
import 'package:task_management_front/models/subtask_list.dart';
import 'package:flutter/material.dart';
import 'package:task_management_front/constants/colors.dart';
import 'package:http/http.dart' as http;

import '../constants/enums.dart';

class Task with ChangeNotifier{
  int? id;
  String? title;
  String? description;
  Priority? priority;
  num? left;
  num? done;
  Color? darkColor;
  Color? lightColor;
  SubtaskList? subtasksList;

  Task({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.left,
    this.done,
    this.subtasksList,
    this.darkColor,
    this.lightColor,
  });

  factory Task.fromJson(dynamic data) {
    final jsonSubtasks = data['subtaskList'] as List;
    var task = Task(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      priority: Priority.values.byName(data['taskPriority']),
      subtasksList: SubtaskList.fromJson(jsonSubtasks),
      left: data['remainSubtasks'],
      done: data['completedSubtasks'],
    );
    task.setColorsByPriority();
    return task;
  }

  Future<void> createTask(Task task) async{
    try{
      final taskBody = {
        'title': task.title,
        'description' : task.description,
        'taskPriority': task.priority?.index,
      };
      http.post(
        Uri.http(HttpConfig.domain, '/tasks'),
        headers: HttpConfig.headers,
        body: jsonEncode(taskBody),
      );
    }catch (error){
      print(error);
      rethrow;
    }
  }

  void setColorsByPriority() {
    switch (priority) {
      case Priority.HIGH:
        darkColor = highRedDark;
        lightColor = highRedLight;
        break;
      case Priority.MEDIUM:
        darkColor = mediumRedDark;
        lightColor = mediumRedLight;
        break;
      case Priority.LOW:
        darkColor = lowGreenDark;
        lightColor = lowGreenLight;
        break;
      default:
        darkColor = kBlueDark;
        lightColor = kBlueLight;
        break;
    }
  }

  Future<void> deleteTask(int? id) async{
    try{
      await http.delete(Uri.http(HttpConfig.domain, '/tasks/$id'));
    }catch (error){
      print(error);
      rethrow;
    }
  }

  Future<void> clone(int? id) async {
    try{
      await http.post(Uri.http(HttpConfig.domain, '/tasks/$id'));
    }catch (error){
      print(error);
      rethrow;
    }
  }
}
